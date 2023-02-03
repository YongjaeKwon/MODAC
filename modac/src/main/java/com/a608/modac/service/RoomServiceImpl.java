package com.a608.modac.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.a608.modac.model.chatting.ChatRoom;
import com.a608.modac.model.participant.Participant;
import com.a608.modac.model.participant.ParticipantPK;
import com.a608.modac.model.room.Room;
import com.a608.modac.model.room.RoomRequest;
import com.a608.modac.model.user.User;
import com.a608.modac.repository.ChatRoomRepository;
import com.a608.modac.repository.ParticipantRepository;
import com.a608.modac.repository.RoomRepository;
import com.a608.modac.model.room.RoomResponse;
import com.a608.modac.repository.UserRepository;

@Service
public class RoomServiceImpl implements RoomService{

	private final RoomRepository roomRepository;
	private final UserRepository userRepository;
	private final ChatRoomRepository chatRoomRepository;
	private final ParticipantRepository participantRepository;

	public RoomServiceImpl(RoomRepository roomRepository, UserRepository userRepository,
		ChatRoomRepository chatRoomRepository, ParticipantRepository participantRepository) {
		this.roomRepository = roomRepository;
		this.userRepository = userRepository;
		this.chatRoomRepository = chatRoomRepository;
		this.participantRepository = participantRepository;
	}

	@Override		// 멀티룸 조회
	public RoomResponse findRoomById(final Long seq) {
		final Room findRoomById = roomRepository.findById(seq).orElseThrow(()->new NoSuchElementException("NoRoom"));
		return new RoomResponse(findRoomById);
	}

	@Override		// 멀티룸 목록 조회
	public List<RoomResponse> findAllRooms() {
		final List<Room> findAllRooms = roomRepository.findAll();
		return findAllRooms.stream().map(RoomResponse::new).collect(Collectors.toList());
	}

	@Override		// 내가 참여하고 있는 비공개 멀티룸 목록 조회
	public List<RoomResponse> findMyRooms(Long userSeq) {
		userRepository.findById(userSeq).orElseThrow(() -> new NoSuchElementException("NoUser"));
		List<Participant> participants = participantRepository.findAllByParticipantPK_UsersSeq(userSeq);
		final List<Room> findMyRooms = new ArrayList<>();

		for(Participant p: participants){
			Room room = roomRepository.findById(p.getParticipantPK().getRoom().getSeq())
				.orElseThrow(NoSuchElementException::new);
			if(room.getPublicType()==0)
			findMyRooms.add(room);
		}
		return findMyRooms.stream().map(RoomResponse::new).collect(Collectors.toList());
	}

	@Override	// 멀티룸 생성
	public RoomResponse createRoom(final RoomRequest roomRequest) {
		User host = userRepository.findById(roomRequest.getUsersSeq()).orElseThrow(() -> new NoSuchElementException("NoUser"));
		String code = null;
		if(roomRequest.getPublicType() == 0){ // 비공개방일때
			// 초대코드 생성 (대충 6자리코드)
			double min = 100000;
			double max = 999999;
			int random = (int) ((Math.random() * (max - min)) + min);
			code = Integer.toString(random);
		}

		// 채팅방 생성
		ChatRoom chatRoom = chatRoomRepository.save(new ChatRoom());
		Room room = roomRepository.save(roomRequest.toEntity(host, chatRoom, code));

		ParticipantPK participantPK = ParticipantPK.builder().room(room).usersSeq(host.getSeq()).build();
		Participant participant = new Participant(participantPK, host);
		participantRepository.save(participant);
		room.getParticipants().set(0, participant);
		room.updateCurrentSize(1);

		return new RoomResponse(roomRepository.save(room));
	}

	@Override
	public RoomResponse updateRoom(final Long seq, final RoomRequest roomRequest) {
		Room room = roomRepository.findById(seq).orElseThrow(() -> new NoSuchElementException("NoRoom"));
		room.updateRoom(roomRequest.getTitle(),
			roomRequest.getDescription(),
			roomRequest.getMultiTheme());
		return new RoomResponse(roomRepository.save(room));
	}

	@Override
	public void deleteRoom(final Long seq) {
		// 멀티룸 참가자들 삭제
		List<Participant> participants = participantRepository.findAllByParticipantPK_Room_Seq(seq);
		for(Participant p : participants){
			participantRepository.delete(p);
		}
		System.out.println("====================111===================");
		// 채팅 로그 먼저 삭제
		// --채팅 로그 삭제하는 로직--

		// 채팅룸 삭제
		ChatRoom chatRoom = roomRepository.findById(seq).orElseThrow(() -> new NoSuchElementException("NoRoom")).getChatRoom();
		chatRoomRepository.delete(chatRoom);

		System.out.println("====================222===================");
		// 멀티룸 삭제
		roomRepository.findById(seq).orElseThrow(() -> new NoSuchElementException("NoRoom"));
		roomRepository.deleteById(seq);
		System.out.println("====================333===================");
	}

	@Override		//멀티룸에 참여하기 (participant 엔티티에서 참가자 저장)
	public RoomResponse joinRoom(Long seq, Long userSeq) {
		Room room = roomRepository.findById(seq).orElseThrow(() -> new NoSuchElementException("NoRoom"));
		User user = userRepository.findById(userSeq).orElseThrow(() -> new NoSuchElementException("NoUser"));

		if(room.getCurrentSize() >= room.getMaxSize()){
			System.out.println("최대인원을 넘을 수 없으므로 참가자가 추가되지 않았습니다.");
			return new RoomResponse(room);
		}

		ParticipantPK participantPK = ParticipantPK.builder().room(room).usersSeq(userSeq).build();
		if (participantRepository.findById(participantPK).isPresent()) {
			System.out.println("이미 방에 참여되어 있는 참가자입니다.");
			return new RoomResponse(room);
		}

		Participant participant = new Participant(participantPK, user);
		participantRepository.save(participant);

		room.participateRoom(participant);
		return new RoomResponse(roomRepository.save(room));
	}

	@Override		//멀티룸에서 나가기
	public void exitRoom(Long seq, Long userSeq) {
		Room room = roomRepository.findById(seq).orElseThrow(() -> new NoSuchElementException("NoRoom"));

		ParticipantPK participantPK = ParticipantPK.builder().room(room).usersSeq(userSeq).build();
		Participant participant = participantRepository.findById(participantPK)
			.orElseThrow(NoSuchElementException::new);

		participantRepository.delete(participant);
		room.exitRoom(participant);
		roomRepository.save(room);
	}

	@Override
	public void updateUserAttend(Long seq, Long userSeq, boolean isAttended) {
		Room room = roomRepository.findById(seq).orElseThrow(() -> new NoSuchElementException("NoRoom"));
		userRepository.findById(userSeq).orElseThrow(() -> new NoSuchElementException("NoUser"));
		List<Participant> participants = room.getParticipants();
		for(Participant p: participants){
			if(p.getParticipantPK().getUsersSeq().equals(userSeq)){
				p.updateAttend(isAttended);
				participantRepository.save(p);
				break;
			}
		}
		roomRepository.save(room);
	}

	@Override
	public boolean isMember(Long seq, Long userSeq) {
		Room room = roomRepository.findById(seq).orElseThrow(() -> new NoSuchElementException("NoRoom"));
		userRepository.findById(userSeq).orElseThrow(() -> new NoSuchElementException("NoUser"));
		List<Participant> participants = room.getParticipants();
		boolean isMember = false;
		for(Participant p: participants){
			if(p.getParticipantPK().getUsersSeq().equals(userSeq)){
				isMember = true;
				break;
			}
		}
		return isMember;
	}

	@Override
	public boolean isSameCode(Long seq, String code) {
		Room room = roomRepository.findById(seq).orElseThrow(() -> new NoSuchElementException("NoRoom"));
		boolean isEqual = room.getInvitationCode().equals(code.trim());
		return isEqual;
	}

	@Override
	public List<RoomResponse> searchRooms(final String keyword) {
		List<Room> rooms = new ArrayList<>();
		rooms.addAll(roomRepository.findAllByTitleContaining(keyword)); // 방 제목으로 검색 (List)
		rooms.addAll(roomRepository.findAllByDescriptionContaining(keyword)); // 방 설명으로 검색 (List)
		List<User> users = userRepository.findAllByNicknameContaining(keyword); // 방장 닉네임으로 검색 (List)
		for(User user : users){
			rooms.addAll(roomRepository.findAllByHost(user));
		}
		rooms.stream().distinct().collect(Collectors.toList()); // 중복 제거
		Collections.sort(rooms, ((o1, o2) -> (int)(o2.getSeq() - o1.getSeq())));
		return rooms.stream().map(RoomResponse::new).collect(Collectors.toList());
	}

}

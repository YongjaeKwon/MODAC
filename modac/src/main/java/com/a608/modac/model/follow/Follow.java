package com.a608.modac.model.follow;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.a608.modac.model.chat.ChatRoom;
import com.a608.modac.model.user.User;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@Entity
@ToString
@Builder
@NoArgsConstructor
@Table(name = "followings")
public class Follow {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long seq;

	@ManyToOne
	@JoinColumn(name = "from_seq")
	private User fromUser;

	@ManyToOne
	@JoinColumn(name = "to_seq")
	private User toUser;

	@ManyToOne
	@JoinColumn(name = "chat_rooms_seq")
	private ChatRoom chatRoom;

	@Builder
	public Follow(final Long seq, final User fromUser, final User toUser, final ChatRoom chatRoom) {
		this.seq = seq;
		this.fromUser = fromUser;
		this.toUser = toUser;
		this.chatRoom = chatRoom;
	}
}

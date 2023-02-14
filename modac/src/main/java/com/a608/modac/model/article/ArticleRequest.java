package com.a608.modac.model.article;

import java.time.LocalDateTime;

import com.a608.modac.model.todo.Todo;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class ArticleRequest {
	private Long usersSeq;
	private Long todosSeq;
	private Byte publicType;
	private String content;

	public ArticleRequest(Long usersSeq, Long todosSeq, Byte publicType, String content) {
		this.usersSeq = usersSeq;
		this.todosSeq = todosSeq;
		this.publicType = publicType;
		this.content = content;
	}

	public Article toEntity(Todo todo, String filepath) {
		return Article.builder()
			.title(todo.getTitle())
			.filepath(filepath)
			.registeredTime(LocalDateTime.now())
			.publicType(this.publicType)
			.viewCount(0)
			.likeCount(0)
			.commentCount(0)
			.totalSecond(todo.getTotalSecond())
			.user(todo.getUser())
			.category(todo.getCategory())
			.build();
	}
}

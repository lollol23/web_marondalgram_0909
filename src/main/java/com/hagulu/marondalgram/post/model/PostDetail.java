package com.hagulu.marondalgram.post.model;

import java.util.List;

import com.hagulu.marondalgram.post.comment.model.Comment;

// DTO, VO
public class PostDetail {
	private Post post;
	private List<Comment> commentList;
	
	public Post getPost() {
		return post;
	}
	public void setPost(Post post) {
		this.post = post;
	}
	public List<Comment> getCommentList() {
		return commentList;
	}
	public void setCommentList(List<Comment> commentList) {
		this.commentList = commentList;
	}
	
	

}

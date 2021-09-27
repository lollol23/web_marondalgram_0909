package com.hagulu.marondalgram.post.comment.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hagulu.marondalgram.post.comment.dao.CommentDAO;
import com.hagulu.marondalgram.post.comment.model.Comment;

@Service
public class CommentBO {
	
	@Autowired
	private CommentDAO commentDAO;

	public int addComment(int userId, int postId, String userName, String content) {
		
		return commentDAO.insertComment(userId, postId, userName, content);
	}
	
	// postId 에 해당하는 댓글 리스트 가져오기
	public List<Comment> getCommentListByPostId(int postId) {
		return commentDAO.selectCommentListByPostId(postId);
	}
}

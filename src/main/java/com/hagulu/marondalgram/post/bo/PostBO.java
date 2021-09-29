package com.hagulu.marondalgram.post.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.hagulu.marondalgram.common.FileManagerService;
import com.hagulu.marondalgram.post.comment.bo.CommentBO;
import com.hagulu.marondalgram.post.comment.model.Comment;
import com.hagulu.marondalgram.post.dao.PostDAO;
import com.hagulu.marondalgram.post.like.bo.LikeBO;
import com.hagulu.marondalgram.post.model.Post;
import com.hagulu.marondalgram.post.model.PostDetail;

@Service
public class PostBO {
	
	@Autowired
	private PostDAO postDAO;
	
	@Autowired
	private CommentBO commentBO;
	
	@Autowired
	private LikeBO likeBO;
	
	public int addPost(int userId, String userName, String content, MultipartFile file) {
				
		String filePath = FileManagerService.saveFile(userId, file);
		
		if(filePath == null) {
			return -1;
		}
		
		return postDAO.insertPost(userId, userName, content, filePath);
	}
	
	public List<PostDetail> getPostList(int userId) {
		
		List<Post> postList = postDAO.selectPostList();
		
		List<PostDetail> postDetailList = new ArrayList<>();
		
		// 포스트 하나당 댓글 가져오기
		for(Post post : postList) {
			// 해당하는 포스트의 댓글 가져오기 
			List<Comment> commentList = commentBO.getCommentListByPostId(post.getId());
			// 해당하는 포스트를 현재 로그인한 사용자가 좋아요 했는지 확인
			boolean isLike = likeBO.likeByUserId(post.getId(), userId);
			// 해당 포스트에 좋아요 개수
			int likeCount = likeBO.likeCount(post.getId());
			
			// post 와 댓글이 매칭 
			PostDetail postDetail = new PostDetail();
			postDetail.setPost(post);
			postDetail.setCommentList(commentList);
			postDetail.setLike(isLike);
			postDetail.setLikeCount(likeCount);
			
			postDetailList.add(postDetail);
		}
		
		
		return postDetailList;
	}
}

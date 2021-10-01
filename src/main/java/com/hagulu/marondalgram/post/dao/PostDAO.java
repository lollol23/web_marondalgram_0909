package com.hagulu.marondalgram.post.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.hagulu.marondalgram.post.model.Post;

@Repository
public interface PostDAO {

	public int insertPost(
			@Param("userId") int userId
			, @Param("userName") String userName
			, @Param("content") String content
			, @Param("imagePath") String imagePath);
	
	public List<Post> selectPostList();
	
	public Post selectPost(@Param("id") int id);
	
	public int deletePost(
			@Param("id") int id
			, @Param("userId") int userId);
	
}
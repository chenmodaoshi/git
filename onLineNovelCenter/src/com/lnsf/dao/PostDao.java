package com.lnsf.dao;
/**
 * 修改人：卢仲贤，陈志锋
 * 日期：2017/7/28
 */

import java.util.Date;
import java.util.List;
import org.hibernate.id.insert.IdentifierGeneratingInsert;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.lnsf.entity.Post;
import com.lnsf.entity.User;


public interface PostDao extends JpaRepository<Post, Integer>,JpaSpecificationExecutor<Post>{
	
	/*
	 *根据用户查找贴子
	 *陆浩锵2017/7/31
	 */
	public List<Post> findByUserOrderByCreatedateDesc(User user );

	
	
	
	//查找所有贴子
	//陈志锋 2017/7/27
	//public List<Post> findAll();
	
	
	//根据贴子等级查找贴子,按最后评论发表时间排序
	//陈志锋 2017/7/27
	public List<Post> findByPlevelOrderByLastdateDesc(Integer plevel);

	
	
	
	//增加贴子
	//陈志锋 2017/7/27
	//public Post savePost(Post post);
	
	
	//根据贴名查找贴子,模糊查找  
	//陈志锋 2017/7/27
	@Query("select post from Post post  where post.pname LIKE %?1%")
	public List<Post> findByPnameLike(String bname );
	
	//根据贴子Id删除贴子，成功返回1，错误返回0
	//陈志锋 2017/7/27
	@Transactional
	@Modifying
	@Query("delete from Post post where postid=?1")
	public Integer removeByPostid(Integer postid );
	
	
	
	//根据用户Id查找贴子
	//陈志锋 2017/7/27
	public List<Post> findByUser(User user );
	
	//根據帖子等級刪除  針對公告
	@Transactional
	@Modifying
	@Query("delete from Post post where post.postid=?1")
	public Integer removeByPlevel(Integer plevel);
	//根據帖子等級加載帖子
	
	
	
	
	//修改贴子等级,成功返回1，失败返回0
	//陈志锋 2017/7/27
	@Transactional
	@Modifying
	@Query("update Post post set post.plevel=:plevel where post.postid=:postid")
	public  Integer setBlevelByPostid(@Param("plevel")Integer plevel,@Param("postid")Integer postid);
	
	//根据用户id删除所有帖子
	//陈志锋 2017/7/27
	@Modifying
	@Transactional
	@Query("delete from Post post where post.user=?1")
	public Integer removeAllByUserid(User user);
	
	
	
}

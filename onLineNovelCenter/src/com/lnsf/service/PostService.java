package com.lnsf.service;

import java.util.List;

import org.springframework.data.domain.Page;

import com.lnsf.entity.Comm;
import com.lnsf.entity.Post;

public interface PostService {
	//查找所有贴子,按最后评论发表时间排序
	public List<Post> loadAllPosts();
	//根据贴子等级查找贴子,按最后评论发表时间排序
	public List<Post> loadPostByPlevel(int plevel);//
	//增加贴子、公告
	public Post savePost(Post post,Comm comm);
	//根据贴名查找贴子,模糊查找
	public List<Post> loadPostByPname(String pname);//
	
	
	//根据贴子Id删除贴子，同时删除贴子的评论,成功返回1，错误返回0
	public int removePostByPostid(int postid);
	
	
	//根据用户Id查找贴子
	public List<Post> loadPostByUserid(int userid);
	//修改贴子等级,成功返回1，失败返回0
	public int modifyPostPlevel(int plevel,int postid);
	//查找所有贴子，按时间排序
	public List<Post> loadPostsTime();
	
	//根据用户id删除所有帖子
	public Boolean removeAllByUserid(int userid); 
	
	//分页查找所有帖子
	public Page<Post> loadPostOrderByTimeAndPage(int requestPageNum,int pageSize);
	
	//根据postid查询帖子--7-29
	public Post getPostByPostid(int postid);
	
	
	//根据帖子类型和帖子标题模糊搜索并排序分页
	public Page<Post> loadPostPageByPtypeAndPname(String searchType,String keyword,Integer requestPageNum,Integer pageSize);
	//增加点击数
	public void addClickNum(Integer postid);
}

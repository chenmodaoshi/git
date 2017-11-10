package com.lnsf.test;

import java.beans.Transient;
import java.util.Date;
import java.util.List;

import javax.servlet.jsp.PageContext;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.lnsf.dao.CommDao;
import com.lnsf.dao.PostDao;
import com.lnsf.dao.UserDao;
import com.lnsf.entity.Post;
import com.lnsf.entity.User;
import com.lnsf.service.CommService;
import com.lnsf.service.PostService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/applicationContext.xml")

public class PostTest {
       @Autowired
       private PostService postService;
      
       @Autowired
       private UserDao userDao;
       @Autowired 
       private CommService commService;
    
     //查找所有贴子,按最后评论发表时间排序
       @Test
   	public void loadAllPosts(){
    	   
   	  List<Post> posts=postService.loadAllPosts();
   	  for(Post post :posts){
   		  
   		  System.out.println(post.getLastdate()+"\n");
   	  }
       }
   	//根据贴子等级查找贴子,按最后评论发表时间排序
       @Test
   	public void loadPostByBlevel(){
    	  
    	   List<Post>list=postService.loadAllPosts();
    	   for(Post post:list){
    		   System.out.println(post.getLastdate());
    	   }
    	   
    	   
       }
   	//增加贴子
       @Test
   	public void savePost(){
		List<User> uList = (List<User>) userDao.findAll();
		Post post = new Post();
		post.setUser(uList.get(0));
		post.setPlevel(3);
		post.setPname("testPost");
		post.setPtype("test1");
		post.setCreatedate(new Date());
		post.setLastdate(new Date());
		post.setMaxfloor(2);
//		postService.savePost(post);
    	   
       }
   	//根据贴名查找贴子,模糊查找
       @Test
   	public void loadPostByBname(){
  	   System.out.println("模糊查找结果数："+postService.loadPostByPname("est").size());
    	
    	   
       }
   	//根据贴子Id删除贴子，同时删除贴子的评论,成功返回1，错误返回0
       @Test    
   	public void removePostByPostid(){
    	   System.out.println("service返回值"+postService.removePostByPostid(13));
    	   
       }
   	//根据用户Id查找贴子
       @Test
   	public void loadPostByU_id(){
    	  postService.loadPostByUserid(4);
       }
   	
   	
   	
   	
   	//修改贴子等级,成功返回1，失败返回0
       @Test
   	public void modifyPostBlevel(){
    	   System.out.println(postService.modifyPostPlevel(1, 10));
       }
   	//查找所有贴子，按时间排序
       @Test
   	public void loadPostsTime(){}
   	//根据用户id删除所有帖子
       @Test
   	public void removeAllByUserid(){
    	   System.out.println(postService.removeAllByUserid(4));
    	   
       }
     //根据帖子发布时间排序并分页
       @Test
   	public  void  loadPostOrderByTimeAndPage() {
    	    Page<Post> page =postService.loadPostOrderByTimeAndPage(2, 3);
    	    
    	    
    	    System.out.println("总页数"+page.getTotalPages());
            System.out.println("当前页码"+ (page.getNumber()+1));
            for(Post post:page.getContent()){
            	System.out.println(post.getCreatedate());
            	
            }
            
            
       }
     //根据类型 贴标题 模糊查询  按时间排序并分页
       @Test
      	public  void  loadPostPageByPtypeAndPname() {
    	   Page<Post>page= postService.loadPostPageByPtypeAndPname("动漫音乐", "wa", 1, 10);
    	   System.out.println("总页数"+page.getTotalPages()+"共结果"+page.getNumberOfElements());
    	  List<Post> pLsit= page.getContent();
    	  
    	   for(Post post: pLsit){
    		   System.out.println(post.getPtype()+"****"+post.getPname()+"***"+post.getCreatedate());
    	   }
       }  
     
     
}

package com.lnsf.test;

import static org.junit.Assert.*;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.lnsf.dao.CommDao;
import com.lnsf.dao.PostDao;
import com.lnsf.dao.UserDao;
import com.lnsf.entity.Comm;
import com.lnsf.entity.Post;
import com.lnsf.entity.User;
import com.lnsf.service.CommService;
import com.lnsf.service.PostService;
import com.lnsf.service.UserService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("/applicationContext.xml")

public class test1 {
	
	@Autowired
    private PostDao postDao;
    @Autowired
    private UserDao userDao;
    @Autowired
    private CommDao commDao;
    @Autowired
    private PostService postService;
    @Autowired
    private CommService commService;
    @Autowired
    private UserService userService;
	
	
	@Test
	
	public void test() {
		for (int i = 10; i < 50; i++) {
			User user = new User();
			user.setAccound("test"+i);
			user.setPwd("123456");
			user.setSex("男");
			user.setPetname("qwe");
			user.setPhone("123");
			user.setPetname("root");
			userService.saveUser(user);
		}	
	}
	
	@Test
	
	public void savePost(){
 	   List<User> uList=(List<User>) userDao.findAll();
 	   for(int i=0;i<110;i++){
 		   User user=uList.get(0);
 		   Post post =new Post();
 	 	   post.setUser(user);
 	 	   post.setPlevel(2);
 	 	   post.setPname("动漫音乐"+i);
 	 	   post.setPtype("动漫音乐");
 	 	   post.setCreatedate(new Date());
 	 	   post.setLastdate(new Date());
 	 	   post.setMaxfloor(1);
 	 	   post.setCommnum(0);
 	 	   post.setClicknum(0);
 	 	   Comm comm=new Comm();
 	 	 comm.setContent("法律框架发来的肌");
		   comm.setFloor(1);
		   comm.setPubdate(new Date());
		   comm.setUser(user);
		   comm.setParent(null);
 	 	   postService.savePost(post,comm);
 	   }
 	

	}
	
	@Test
	
	public void saveComm(){
		 List<Post> pList=(List<Post>) postDao.findAll();
		 List<User> uList =(List<User>)userDao.findAll();
		 for(int i=1;i<20;i++){
			 Comm comm=new Comm();
			 comm.setContent("testComm"+i);
			 comm.setFloor(i);
			 comm.setParent(null);
			 comm.setPost((Post)pList.get(1));
			 comm.setPubdate(new Date());
			 comm.setUser((User)uList.get(i));
			 
			 System.out.println(commDao.save(comm));
		 }
	}
	
	
	@Test
	public void test_removeError(){
		//System.out.println(commService.removeCommByCommid(22222));
		//System.out.println(commService.removeCommByPostid(2225));
		//System.out.println(commService.removeCommByUserid(3222));
		System.out.println(userService.removeUser(3));
	}

}

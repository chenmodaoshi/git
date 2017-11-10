package com.lnsf.controller;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lnsf.entity.Comm;
import com.lnsf.entity.Post;
import com.lnsf.service.CommService;
import com.lnsf.service.PostService;
import com.lnsf.service.UserService;
import com.lnsf.util.CommComparatpor;
//我在测试
@Controller
public class CommController {
	
		@Autowired
		private CommService commService; 
		@Autowired
		private PostService postService;
		@Autowired
		private UserService userService;
		static final private Integer pageSize=2;
		//首页中的 去进详情页
		@RequestMapping("goScondCommByPostId")
		public String goScondCommByPostId(Integer postId,HttpServletRequest request){
			request.setAttribute("postId",postId);
			//System.out.println("goScondCommByPostId");
			postService.addClickNum(postId);
			int i=commService.getcountcommbyPostid(postId);
			if(i%pageSize==0){
				i=i/pageSize;
			}else{
				i=i/pageSize+1;
			}
		
			request.setAttribute("postCount",i);
			return "secondComm";
		};
		
		//详情页
		@RequestMapping("getAllCommByPostId")
		@ResponseBody	//JSON数据  和AJAX配套使用
		public List<Comm> getAllCommByPostId(Integer postId,Integer requestPageNum,HttpServletRequest request){
			//System.out.println("getAllCommByPostId2："+commService.loadCommByPostid(postId));
			List <Comm>page =commService.loadCommPageByPostid(postId, requestPageNum, pageSize);
			CommComparatpor co =new CommComparatpor();
			Collections.sort(page, co);
			Post post=postService.getPostByPostid(postId);
			request.setAttribute("pname",post.getPname());
			int i=commService.getcountcommbyPostid(postId);
			if(i%pageSize==0){
				i=i/pageSize;
			}else{
				i=i/pageSize+1;
			}
			System.out.println(page.size());
			request.setAttribute("postCount",i);
			return page;
		};
		
		
		
		@RequestMapping(value="addComm",method=RequestMethod.POST)
		@ResponseBody	//JSON数据  和AJAX配套使用
		public Integer addComm(Comm comm,HttpServletRequest request){		//get
			
			Comm c= commService.saveComm(comm);
			c.setUser(userService.loadUserByUserid(c.getUser().getUserid()));
			System.out.println(c);
			System.out.println("add: "+c );
			int postId=comm.getPost().getPostid();
			List <Comm>page =commService.loadCommPageByPostid(postId, 1, pageSize);
			CommComparatpor co =new CommComparatpor();
			Collections.sort(page, co);
			int i=commService.getcountcommbyPostid(postId);
			if(i%pageSize==0){
				i=i/pageSize;
			}else{
				i=i/pageSize+1;
			}
			
			int commCount=i;
			request.setAttribute("postCount",commCount);
			
			
			return commCount;
		};
		
		/**
		 * 8-1 个人页面显示自己所有的评论
		 * @param userid
		 * @param row
		 * @param page
		 * @return
		 */
		@RequestMapping(value="/getCommByPage",method = RequestMethod.GET)
		@ResponseBody
		public List<Object> getCommByPage(int userid,int row , int page){
			int minnum = (page-1)*row;
			int maxnum = row*page;
			List<Comm> comms = commService.loadCommByUseridpage(userid, minnum, maxnum);
			int lenth=commService.loadCommByUserid(userid).size();
			if(lenth%10==0){
				lenth=lenth/10;
			}else{
				lenth=lenth/10+1;
			}
			List<Object> cList=new ArrayList<Object>();
			cList.add(lenth);
			cList.add(comms);
			return cList;
		}
		
		@RequestMapping(value="saveanswer",method=RequestMethod.POST)
		@ResponseBody	//JSON数据  和AJAX配套使用
		public Comm saveanswer(Comm comm,int parentid){		//get
			Comm comm1= commService.saveanswer(comm);
			commService.updateparent(parentid, comm1.getCommid());
			
			return comm1;
		};
		
		/*
		@RequestMapping(value="addComm",method=RequestMethod.POST)
		@ResponseBody	//JSON数据  和AJAX配套使用
		public String addComm(CommInUp commInUp){
			 int i=commService.CommRow(3);
			 System.out.println("addcomm "+i);
			 System.out.println(commInUp.getUserid()+"  "+commInUp.getContent());
			return "success";
		};*/
		/*org.springframework.beans.factory.BeanCreationException: Error creating bean with name 'entityManagerFactory' defined in class path resource [applicationContext.xml]: Invocation of init method failed; nested exception is javax.persistence.PersistenceException: [PersistenceUnit: default] Unable to build EntityManagerFactory*/
}

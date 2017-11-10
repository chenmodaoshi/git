package com.lnsf.controller;


import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lnsf.entity.Comm;
import com.lnsf.entity.Post;
import com.lnsf.entity.User;
import com.lnsf.service.PostService;
import com.sun.media.sound.AlawCodec;


@Controller
public class PostController {
	
	@Autowired
	private PostService postService;
	
	
	//分頁加載Post 根据帖子等级、最新评论时间排序
	@RequestMapping(value="/loadPostByPage",method=RequestMethod.GET)
	@ResponseBody
	public List<Object> loadPostByPage(int requestPageNum){
		int pageSize=10;
		 List<Object> list=new ArrayList<Object>();
		 Page<Post> page= postService.loadPostOrderByTimeAndPage(requestPageNum, pageSize);
		 List<Post> pList=page.getContent();
		 int pageCount=page.getTotalPages();
		 int currentPageNum=page.getNumber();
		 list.add(pageCount);
		 list.add(pList);
		// list.add(currentPageNum);
		
		return list;
	}
	//保存帖子 、公告
	@RequestMapping(value="/publishPost",method=RequestMethod.POST)
	@ResponseBody
	public String publishPost(String ptype,String pname,String content,HttpSession session){
		   User user=(User)session.getAttribute("user");
		   if(user!=null) {
			   if(user.getStatus()==1) 
				   return "forbid";
			   Post post=new Post();
			   post.setPtype(ptype);
			   post.setPname(pname);
			   post.setCreatedate(new Date());
			   post.setLastdate(new Date());
			   post.setMaxfloor(1);
			   if("公告".equals(post.getPtype()))
				   post.setPlevel(0); //公告等级为0
			   else 
			       post.setPlevel(2);//普通帖子等级为2
			   post.setUser(user);
			   Comm comm =new Comm();
			   comm.setContent(content);
			   comm.setFloor(1);
			   comm.setPubdate(new Date());
			   comm.setUser(user);
			   comm.setParent(null);
			   Post newPost =postService.savePost(post, comm);
			   if(newPost!=null&&newPost==post) 
				   return "true";
			   else 
			       return "false";
		   }
		   
		    
		   else
			   return "off_line";
	}
	//转发请求到搜索结果页
	@RequestMapping(value="/toSeachPostResultPage",method=RequestMethod.GET)
	public ModelAndView toSeachPostResultPage(String searchType,String keyword){
		ModelAndView mav = new ModelAndView();
		mav.addObject("searchType", searchType);
		mav.addObject("keyword", keyword);
		mav.setViewName("searchResult");
	   return mav;
	}
	 //分类 关键词搜索帖子  
	 //陈志锋2017/7/31
	@RequestMapping(value="/seachPostByPtypeAndPname",method=RequestMethod.GET)
	@ResponseBody
	public List<Object> seachPostByPtypeAndPname(String searchType,String keyword,Integer  requestPageNum){
		List<Object> list=new ArrayList<Object>();
		System.out.println("搜索类型:"+searchType+"关键词"+keyword+"请求页码:"+requestPageNum);
		
		
		 Page<Post> page=postService.loadPostPageByPtypeAndPname(searchType, keyword, requestPageNum, 10);
		 //Page<Post> page =postService.loadPostOrderByTimeAndPage(requestPageNum, 10);
		 List<Post> pList=page.getContent();
		 int pageCount=page.getTotalPages();
		 list.add(pageCount);
		 list.add(pList);
		 return list;
	}
	//分頁加載个人Post
	@RequestMapping(value="/loadPostByUser",method=RequestMethod.GET)
	@ResponseBody
	public List<Object> loadPostByUser(int requestPageNum,int userid){
		int pageSize=10;
		List<Object> list=new ArrayList<Object>();
		List<Post> pList=null;
		pList=postService.loadPostByUserid(userid);
		int size=pList.size();
		int pageCount;
		if (size%10==0) {
			pageCount=size/10;
		}else {
			pageCount=size/10+1;
		}
		int start=(requestPageNum-1)*10;
		int end;
		if(start+9>pageCount){
			end=pList.size()-1;
		}else {
			end=start+9;
		}
		List<Post> p=new ArrayList<Post>();
		for (int i = start; i <= end; i++) {
			p.add(pList.get(i));
		}
		System.out.println(pageCount);
		list.add(pageCount);
		list.add(p);
		return list;
	}
	/**
	 * 根据输入贴名的关键字进行模糊查找
	 * @param pname
	 * @return 返回一组搜索结果
	 */
	@RequestMapping(value="/searchPostByPname",method=RequestMethod.GET)
	@ResponseBody
	public List<Post> searchPostByPname(String pname){
		List<Post> post;
		if(pname!=null&&!pname.equals("")){
			post = postService.loadPostByPname(pname);
		}
		else{
			post = postService.loadAllPosts();
		}	
		return post;
	}	
	
	/**
	 * 返回帖子列表，不进行分页
	 * @return
	 */
	@RequestMapping(value="/showPost")
	@ResponseBody
	public List<Post> showPost(){
		return postService.loadAllPosts();
	}
	
	/**
	 * 删除功能 7-30：同时在DAO里加了一个事务处理
	 * @param postid
	 * @return
	 */
	@RequestMapping(value="/deletePost",method=RequestMethod.GET)
	@ResponseBody
	public String deletePost(int postid,HttpSession session){
		int flag=-1;
		User user = (User)session.getAttribute("user");
		if(user.getPow()==0){
			flag = postService.removePostByPostid(postid);
			if(flag>0){
				return "success";
			}
			else
				return "error";
		}
		else
			return "error";
	}
	
	/**7-31
	 * 更改帖子等级，重新加载数据，在DAO层的setBlevelByPostid方法加上了@Transactional
	 * @param postid
	 * @param plevel
	 * @return
	 */
	@RequestMapping(value="/updatePostLeve",method=RequestMethod.GET)
	@ResponseBody
	public String updatePostLeve(int postid,int plevel){
		int flag = -1;
		try {
			flag = postService.modifyPostPlevel(plevel, postid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		if( flag > 0 && plevel==1){
			return "success1";
		}else if( flag > 0 && plevel==2){
			return "success2";
		}
		else{
			return "error";
		}
	}
}

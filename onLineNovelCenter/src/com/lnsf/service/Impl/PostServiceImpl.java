package com.lnsf.service.Impl;

import java.nio.file.Path;
import java.text.SimpleDateFormat;
/**
 * 修改人：卢仲贤，陈志锋
 * 日期：2017/7/28
 * 
 */
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

//import javax.persistence.criteria.Path;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.domain.Sort.Order;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lnsf.dao.CommDao;
import com.lnsf.dao.PostDao;
import com.lnsf.dao.UserDao;
import com.lnsf.entity.Comm;
import com.lnsf.entity.Post;
import com.lnsf.entity.User;
import com.lnsf.service.PostService;
import com.mchange.v1.db.sql.CBPUtils;
import com.sun.org.apache.xpath.internal.axes.PredicatedNodeTest;

@Service("postService")
public class PostServiceImpl implements PostService {
	 @Autowired
     private PostDao postDao;
     @Autowired
     private UserDao userDao;
     @Autowired
     private CommDao commDao;
	//查找所有贴子,按最后评论发表时间排序
   //陈志锋 2017/7/27
	@Override
	public List<Post> loadAllPosts() {
		Order lastdateOrder=new Order(Sort.Direction.DESC, "lastdate");
		Order commnumOrder=new Order(Sort.Direction.DESC, "commnum");
		Order clicknumOrder=new Order(Sort.Direction.DESC, "clicknum");
		List<Order> oList=new ArrayList<Order>();
		oList.add(lastdateOrder);
		oList.add(commnumOrder);
		oList.add(clicknumOrder);
		Sort sort =new Sort(oList);
		List<Post> list=(List<Post>) postDao.findAll(sort);
		
		
		return list;
	}
	//根据贴子等级查找贴子,按最后评论发表时间排序
	//陈志锋 2017/7/27
	@Override
	public List<Post> loadPostByPlevel(int plevel) {
//           List<Post> list=(List<Post>) postDao.findByBlevelOrderByLast_dateDesc(blevel);
           List<Post> list=(List<Post>) postDao.findByPlevelOrderByLastdateDesc(plevel);
		return list;
	}
	//增加贴子 公告
	//陈志锋 2017/7/27
	@Override
	@Transactional
	public Post savePost(Post post,Comm comm) {
		//處理舊公告
		if(post.getPlevel()==0){ //判断是否发新公告
		    List<Post> pList=postDao.findByPlevelOrderByLastdateDesc(0);//查找老公告
		    
		    for(Post notice : pList){
		    	List <Comm> cList=commDao.findBypostid(notice.getPostid());//查找公告内容
		    	commDao.delete(cList); //刪除公告内容	
		    }
		     postDao.delete(pList);
		}
		
		//處理新帖、新公告
		post.setClicknum(0);
		post.setCommnum(0);
		Post newPost=postDao.save(post);
		if(newPost!=null){
			comm.setPost(newPost);
			Comm newComm=commDao.save(comm);
			if(newComm==null)
				newPost=null;
		}
		return newPost;
	}
	//根据贴名查找贴子,模糊查找
	//陈志锋 2017/7/27
	@Override
	public List<Post> loadPostByPname(String pname) {
		// TODO Auto-generated method stub
		
		return postDao.findByPnameLike(pname);
	}
	//根据贴子Id删除贴子，同时删除贴子的评论,成功返回1，错误返回0
	//陈志锋 2017/7/27
	@Override
	@Transactional(timeout=5)
	public int removePostByPostid(int postid) {
		// TODO Auto-generated method stub   
		List<Comm> comm = commDao.findBypostid(postid);
		for(int i = 0; i<comm.size();i++) {
			commDao.delete(comm.get(i));
		}
		commDao.flush();
		int count=postDao.removeByPostid(postid);//删除post表
		if(count>0) 
			return 1;
		else 
			return 0;
			
	}

    //根据用户Id查找贴子
	//陆浩锵修改2017/7/30
	@Override
	public List<Post> loadPostByUserid(int userid) {
		// TODO Auto-generated method stub
		User user=new User();
		user.setUserid(userid);
		List<Post> p=null;
		p=postDao.findByUserOrderByCreatedateDesc(user);
		return p;
		
	}
	//修改贴子等级,成功返回1，失败返回0
	//陈志锋 2017/7/27
	@Override
	@Transactional
	public int modifyPostPlevel(int plevel, int postid) {
		// TODO Auto-generated method stub
		int count=postDao.setBlevelByPostid(plevel, postid);
		if(count>0) return 1;
		else return 0;
	}
	//查找所有贴子，按时间排序
	//陈志锋 2017/7/27
	@Override
	public List<Post> loadPostsTime() {
		Order order=new Order(Sort.Direction.DESC, "lastdate");
		Sort sort =new Sort(order);
		return (List<Post>) postDao.findAll(sort);
	}
	//根据用户id删除所有帖子
	//陈志锋 2017/7/27
	@Override
	@Transactional
	public Boolean removeAllByUserid(int userid) {
		// TODO Auto-generated method stub
		
         User user=userDao.findOne(userid);
         List<Post> pList=postDao.findByUser(user);
         for(Post post : pList){ 
        	List<Comm> comm = commDao.findBypostid(post.getPostid());
     		for(int i = 0; i<comm.size();i++) {
     			commDao.delete(comm.get(i));
     		}
         }

        if(postDao.removeAllByUserid(user)>0)
    		 return true;
        else
    		 return false;

	}
	//根据帖子发布时间排序并分页
	@Override
	public Page<Post> loadPostOrderByTimeAndPage(int requestPageNum,int pageSize) {
		// TODO Auto-generated method stub
		List <Order> oList=new ArrayList<Order>();
		Order orderByLevel=new Order(Direction.ASC, "plevel");
		Order orderByCreateDate=new Order(Direction.DESC, "lastdate");
		Order commnumOrder=new Order(Sort.Direction.DESC, "commnum");
		Order clicknumOrder=new Order(Sort.Direction.DESC, "clicknum");
		oList.add(orderByLevel);
		oList.add(orderByCreateDate);
		oList.add(commnumOrder);
		oList.add(clicknumOrder);
		Sort sort=new Sort(oList);
		PageRequest pageRequest=new PageRequest(requestPageNum-1, pageSize, sort);
		return postDao.findAll(pageRequest);
			
	}
	//根据postid查找帖子7-29
	@Override
	public Post getPostByPostid(int postid) {
		// TODO Auto-generated method stub
		return postDao.findOne(postid);
	}
	//根据帖子类型和帖子标题模糊搜索并排序分页
	//ccc
	@Override
	public Page<Post> loadPostPageByPtypeAndPname( final String searchType, final String keyword, Integer requestPageNum,
			Integer pageSize) {
		    Order order1=new Order(Direction.DESC,"lastdate");
		    Order order2=new Order(Direction.DESC,"commnum");
		    Order order3=new Order(Direction.DESC,"clicknum");
		    List <Order> orderList= new ArrayList<Order>();
		    orderList.add(order1);
		    orderList.add(order2);
		    orderList.add(order3);
		    Sort sort=new Sort(orderList);
		    PageRequest pageable=new PageRequest(requestPageNum-1, pageSize, sort);
		    Specification<Post> spec=new Specification<Post>() {
		    	@Override
		    	 public Predicate toPredicate(Root<Post> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
					List<Predicate> predicates=new ArrayList<Predicate>();
					javax.persistence.criteria.Path<String> ptype=root.get("ptype");
		    	 	Predicate _ptype=cb.equal(ptype, searchType);
		    	 	predicates.add(_ptype);
					javax.persistence.criteria.Path<String> pname= root.get("pname");
					Predicate _pname=cb.like(pname, "%"+keyword+"%");
		    	 	predicates.add(_pname);
		    	 	System.out.println(predicates.toArray(new Predicate[]{}));
		    	 	return cb.and(predicates.toArray(new Predicate[]{}));
		    		
		    	}
		    };
		    Page<Post> page=(Page<Post>) postDao.findAll(spec,pageable);
		    //Page<Post> page=(Page<Post>) postDao.findAll(spec);
		    return page;
	}
	  //增加点击数
		@Override
		@Transactional
		public void addClickNum(Integer postid) {
			// TODO Auto-generated method stub
			Post post =postDao.findOne(postid);
			post.setClicknum(post.getClicknum()+1);
			postDao.saveAndFlush(post);
		}

}

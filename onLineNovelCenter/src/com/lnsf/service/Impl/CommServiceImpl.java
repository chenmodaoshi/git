package com.lnsf.service.Impl;

import java.util.ArrayList;
/**
 * 修改人：卢仲贤
 * 日期：2017/7/28
 */
import java.util.Date;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.hibernate.id.IntegralDataTypeHolder;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
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
import com.lnsf.service.CommService;

@Service("commService")
public class CommServiceImpl implements CommService {

	@Autowired
	private CommDao commDao;
	@Autowired
	private PostDao postDao;
	@Autowired
	private UserDao userDao;
	
	
	@Override
	public int CommRow(Integer postid) {
		Integer count = commDao.findcountcommbypostid(postid);
		return count;
	}

	@Transactional
	@Override
	public Comm saveComm(Comm comm) {
		Date date=new Date();
		Post post = postDao.findOne(comm.getPost().getPostid());
		post.setMaxfloor(post.getMaxfloor()+1);
		post.setCommnum(post.getCommnum()+1);
		post.setLastdate(date);
		postDao.save(post);
		comm.setFloor(post.getMaxfloor());
		comm.setPubdate(date);
		Comm c=commDao.save(comm);
		return c;
	}
	@Override
	public List<Comm> loadCommByPostid(int postid) {
		List<Comm> comms = commDao.findBypostid(postid);
		return comms;
	}
	
	
	
	
//	@Override
//	public Page<Comm> loadCommPageByPostid(final Integer postid,Integer requestPageNum,Integer pageSize) {
//		Order order =new Order(Direction.ASC, "floor");
//		Sort sort =new Sort(order);
//		PageRequest pageRequest=new PageRequest(requestPageNum-1, pageSize, sort);
//		Specification<Comm> spec=new Specification<Comm>() {
//			
//			@Override
//			public Predicate toPredicate(Root<Comm> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
//				Path<Integer> postPath=root.get("post");
//				Path<List<Comm>> parentPath=root.get("parent");
//				Predicate postCondition=cb.equal(postPath, postid);
//				
//				
//				Predicate parentCondition=cb.isNull(parentPath);
//				List<Predicate> predicates=new ArrayList<Predicate>();
//				predicates.add(postCondition);
//				predicates.add(parentCondition);
//				return cb.and(predicates.toArray(new Predicate[]{}));
//			}
//		};
//		
//		
//		return commDao.findAll(spec, pageRequest);
//	}
	@Override
	public List<Comm> loadCommByUserid(int userid) {
		List<Comm> comms = commDao.findByuserid(userid);
		return comms;
	}
	
	//8-1
	@Override
	public List<Comm> loadCommByUseridpage(int userid, int minnum, int maxnum) {
		List<Comm>comms = commDao.findByuseridpage(userid, minnum, maxnum);
		return comms;
	}
	
	@Override
	@Transactional
	public int removeCommByCommid(int commid) {
		commDao.delete(commid);
		return 1;
	}
	
	@Override
	@Transactional
	public int removeCommByUserid(int userid) {
		
		List<Comm> comm = commDao.findByuserid(userid);
		for(int i = 0; i<comm.size();i++) {
			commDao.delete(comm.get(i));
		}
		return 1;
	}
	
	@Override
	@Transactional
	public int removeCommByPostid(int postid) {
		List<Comm> comm = commDao.findBypostid(postid);
		for(int i = 0; i<comm.size();i++) {
			commDao.delete(comm.get(i));
		}
		return 1;
	}
	
	
	@Override
	@Transactional
	public int updateparent(Integer parent , Integer commid) {
		int count= commDao.updateparent(parent, commid);
		if(count>0)
			return 1;
		else
			return 0;
	}
	
	@Transactional
	@Override
	public Comm saveanswer(Comm comm) {
		Date date=new Date();
		comm.setParent(null);
		comm.setPubdate(date);
		Comm c=commDao.save(comm);
		Post post=postDao.findOne(c.getPost().getPostid());
		post.setLastdate(date);
		post.setCommnum(post.getCommnum()+1);
		postDao.saveAndFlush(post);
		return c;
	}

	@Override
	public List<Comm> loadCommPageByPostid(Integer postid, Integer requestPageNum, Integer pageSize) {
		int minnum = (requestPageNum-1)*pageSize+1;
		int maxnum = requestPageNum * pageSize;
		return commDao.findByPostidpage(postid, minnum, maxnum);
		
	}
	
	@Override
	public Integer getcountcommbyPostid(int postid){
		return commDao.findcountcommbypostid(postid);
	}
}

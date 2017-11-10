package com.lnsf.service.Impl;

/**
 * 修改人：卢仲贤
 * 日期：2017/7/28
 */
import java.util.Date;
import java.util.List;




import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.lnsf.dao.CommDao;
import com.lnsf.dao.PostDao;
import com.lnsf.dao.UserDao;
import com.lnsf.entity.Comm;
import com.lnsf.entity.Post;
import com.lnsf.entity.User;
import com.lnsf.service.UserService;

import oracle.net.aso.i;

@Service("userService")
public class UserServiceImpl implements UserService {

	@Autowired
    private PostDao postDao;
    @Autowired
    private UserDao userDao;
    @Autowired
    private CommDao commDao;
	
	@Override
	public User loadUser(String accound, String pwd) {
		User u=null;
		u=userDao.getUserByAccound(accound);
		if(u!=null&&u.getPwd().equals(pwd)){
			return u;
		}else{
			return null;
		}
	}

	@Transactional
	@Override
	public User saveUser(User user) {
		User u=null;
		if(user.getPow()==null){
			user.setPow(2);//默认权限
			user.setRegdate(new Date());
			user.setStatus(0);
			user.setHead("img/userhead.jpg");
		}
		u=userDao.save(user);
		// TODO Auto-generated method stub
		return u;
	}

	@Override
	public User loadUserByUserid(int userid) {
		User u=null;
		u=userDao.findOne(userid);
		return u;
	}

	@Transactional
	@Override//
	public User modifyUser(User user) {
		User u=null;
		u=userDao.save(user);
		return u;
	}

	/**
	 * 修改人：陆浩锵
	 * 时间：8/1/15时
	 */
	@Override
	public int removeUser(int userid) {
		List<Comm> comm = commDao.findByuserid(userid);
		User user=userDao.findOne(userid);
		List<Post> pList=postDao.findByUser(user);
		commDao.delete(comm);
        for(Post post : pList){
        	comm = commDao.findBypostid(post.getPostid());
        	if (comm!=null) {
        		commDao.delete(comm);
			}
        }
        commDao.flush();
        postDao.removeAllByUserid(user);
        postDao.flush();
        userDao.delete(user);
		return 1;
	}

    //
	@Transactional
	@Override
	public User modifyUserPow(int userid, int pow) {
		User user=null;
		user=userDao.findOne(userid);
		user.setPow(pow);
		user=userDao.save(user);
		return user;
	}

	@Override
	public User modifyUserStatus(int userid,int status) {
		User user=null;
		user=userDao.findOne(userid);
		user.setStatus(status);
		user=userDao.save(user);
		return user;
	}

	@Override
	public List<User> loadAllUsers() {
		return userDao.findAll();
	}

	@Override
	public User loadUserByAccound(String accound) {
		User user=null;
		user=userDao.getUserByAccound(accound);
		return user;
	}
	
	@Override
	public Page<User> loadUsersPage(int requestPageNum, int pageSize) {
		PageRequest pageRequest=new PageRequest(requestPageNum-1, pageSize);
		return userDao.findAll(pageRequest);
	}

	@Override
	public Page<User> loadUserPageByPetnameLike(final String petName,Integer requestPageNum,Integer pageSize) {
		PageRequest pageable=new PageRequest(requestPageNum-1, pageSize);
		
		Specification<User> spec=new Specification<User>() {
	    	@Override
	    	 public Predicate toPredicate(Root<User> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
				javax.persistence.criteria.Path<String> path= root.get("petname");
				Predicate searchCondition=cb.like(path, "%"+petName+"%");
	    	 	return searchCondition;
	    		
	    	}

			
	    };
	    Page<User> page=(Page<User>) userDao.findAll(spec,pageable);
	   
	    return page;
	}

}

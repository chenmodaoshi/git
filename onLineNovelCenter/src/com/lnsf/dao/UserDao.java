package com.lnsf.dao;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import com.lnsf.entity.Post;
import com.lnsf.entity.User;


public interface UserDao extends JpaRepository<User, Integer>,JpaSpecificationExecutor<User>{
	
	public User getUserByAccound(String accound);
	
	@Modifying
	@Query(value="delete from users where userid = ?1", nativeQuery=true)	
	public Integer removeByuserid(Integer userid);
}

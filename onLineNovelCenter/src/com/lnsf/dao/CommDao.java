package com.lnsf.dao;
/**
 * 修改人：卢仲贤
 * 日期：2017/7/28
 */
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.transaction.annotation.Transactional;

import com.lnsf.entity.Comm;
import com.lnsf.entity.Post;

public interface CommDao extends JpaRepository<Comm, Integer>,JpaSpecificationExecutor<Comm>{
	//根据userid查询并分页
	//2017-8-1改
	@Query(value="select * from(select com.* ,rownum rn from (select * from comm where userid = ?1) com)where rn between ?2 and ?3" , nativeQuery=true)
	public List<Comm> findByuseridpage(Integer userid,int minnum,int maxnum);
	
	@Query(value="select * from(select com.* ,rownum rn from (select * from comm where postid = ?1 and parent is null order by floor) com)where rn between ?2 and ?3" , nativeQuery=true)
	public List<Comm> findByPostidpage(Integer postid,int minnum,int maxnum);
	
	
	//按照postid查询comm数量
	@Query(value="select count(commid) from comm where postid = ?1 and parent is null" , nativeQuery=true)
	public Integer findcountcommbypostid(Integer postid);
	
	//按照userid查询所有comm
	@Query(value="select * from comm where userid = ?1" , nativeQuery=true)
	public List<Comm> findByuserid(Integer userid);
	
	//按照postid查询所有parent 为null 的comm
	@Query(value="select * from comm where postid = ?1 and parent is null" , nativeQuery=true)
	public List<Comm> findBypostid(Integer postid);
	
	//按照commid和parent的id 更改parent
	@Modifying@Transactional
	@Query(value="update  comm set parent = ?1 where commid = ?2", nativeQuery=true)	
	public Integer updateparent(Integer parent,Integer commid);
	
}

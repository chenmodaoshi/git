package com.lnsf.service;

import java.util.List;

import org.springframework.data.domain.Page;
import com.lnsf.entity.Comm;


public interface CommService {
	//根据用户ID查找评论   ///该方法有修改 2017-8-1
	public List<Comm> loadCommByUseridpage(int userid, int minnum, int maxnum);
	//根据贴子查找评论数
	public int CommRow(Integer Postid);
	//添加评论
	public Comm saveComm(Comm comm);
	//根据贴子ID查找评论,找parent为空的,并找出它的儿子
	public List<Comm> loadCommByPostid(int Postid);
	//根据用户ID查找评论
	public List<Comm> loadCommByUserid(int userid);
	//根据评论ID删除评论，成功返回1，失败返回0
	public int removeCommByCommid(int commid);
	
	//根据用户id删除评论，成功返回1，失败返回0
	public int removeCommByUserid(int userid);
	//根据贴id删除评论，成功返回1，失败返回0
	public int removeCommByPostid(int Postid);
	
	public int updateparent(Integer parent, Integer commid);
	
	public Comm saveanswer(Comm comm);
	//帖子详情分页  根据贴子ID查找评论,找parent为空的,并找出它的儿子
	public List<Comm> loadCommPageByPostid(Integer postid,Integer requestPageNum,Integer pageSize);
	//获取贴的评论总数
	public Integer getcountcommbyPostid(int postid);
}

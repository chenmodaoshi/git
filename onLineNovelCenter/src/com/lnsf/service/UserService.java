package com.lnsf.service;

import java.util.List;

import org.springframework.data.domain.Page;

import com.lnsf.entity.User;

public interface UserService {
	//登陆，成功返回返回用户，失败返回null
	public User loadUser(String accound,String pwd);
	//添加用户，成功返回用户，失败返回null
	public User saveUser(User user);
	//根据用户ID查找用户
	public User loadUserByUserid(int userid);
	//修改用户信息
	public User modifyUser(User user);
	//删除用户,成功返回1，失败返回0
	public int removeUser(int userid);
	//修改用户权限，成功返回用户
	public User modifyUserPow(int userid,int pow);
	//修改用户状态,成功返回用户
	public User modifyUserStatus(int userid,int status);
	//查找所有用户
	public List<User> loadAllUsers();
	//根据用户账号查找用户
	public User loadUserByAccound(String accound);
	//分页查找所有帖子
	public Page<User> loadUsersPage(int requestPageNum,int pageSize);
	//模糊查找用户 并分页
		public Page<User> loadUserPageByPetnameLike(String petName,Integer requestPageNum,Integer pageSize);
}

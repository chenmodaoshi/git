package com.lnsf.controller;
import java.io.File;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.lnsf.entity.User;
import com.lnsf.service.UserService;
import com.lnsf.util.JsonDateValueProcessor;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

@Controller
public class UserController {
	@Autowired
	private UserService userService;
	
	@ModelAttribute("getUser")
	public User getUser(@RequestParam(value="userid",required=false) Integer userid){
		User user=null;
		if (userid!=null) {
			user=userService.loadUserByUserid(userid);	
		}
		return user;
	}
	
	@RequestMapping("/registerUser")
	@ResponseBody
	public String registerUser(User user,int pwd2){
		if(userService.loadUserByAccound(user.getAccound())!=null){
			return "exist";
		}
		userService.saveUser(user);
		return "success";
	}
	
	
	@RequestMapping("/loginUser")
	@ResponseBody
	public String loginUser(String accound,String pwd,HttpSession session){
		User user=null;
		user=userService.loadUserByAccound(accound);
		if (user!=null&&user.getPwd().equals(pwd)) {
			session.setAttribute("user", user);
			return "success";
		}else if (user!=null) {
			return "pwdError";
		}else {
			return "exist";
		}
	}
	
	@RequestMapping("/logoutUser")
	@ResponseBody
	public String logoutUser(HttpSession session){
		session.setAttribute("user", null);
		return "success";
	}
	
	@RequestMapping("/myuser")
	public String myuser(){
		return "user";
	}
	
	@RequestMapping("/modifyUser")
	@ResponseBody
	public String modifyUser(@ModelAttribute("getUser") User user,HttpSession session){
		User u=userService.loadUserByUserid(user.getUserid());
		if(u.getPwd().equals(user.getPwd())){
			userService.saveUser(user);
			session.setAttribute("user", user);
			return "success";
		}else {
			session.setAttribute("user", null);
			userService.saveUser(user);
			return "pwdChange";
		}
	}
	
	@RequestMapping("/removeUser")
	@ResponseBody
	public String removeUser(Integer userid){
		userService.removeUser(userid);
		return "success";
	}
	

	@RequestMapping(value="/showalluser",method=RequestMethod.GET)
	@ResponseBody
	public JSONObject showAllUser(int pow,int page,int rows,HttpServletRequest request){
		JsonConfig jsonConfig = new JsonConfig();  
		jsonConfig.registerJsonValueProcessor(Date.class,new JsonDateValueProcessor());
		Page<User> pages=userService.loadUsersPage(page,rows);
		List<User> users=pages.getContent();
		Map<String,Object> result=new HashMap<String,Object>();  
		result.put("total", userService.loadAllUsers().size());
		result.put("pageNumber",page);
		result.put("rows", users);  
		JSONObject jsonObject=new JSONObject();
		jsonObject.putAll(result, jsonConfig);
		System.out.println(jsonObject.toString());
		return jsonObject;
	}
	
	@RequestMapping("adminModifyUser")
	@ResponseBody
	public String adminModifyUser(@ModelAttribute("getUser") User user,HttpSession session){
		if(userService.saveUser(user)!=null){
			return "success";
		}else {
			return "error";
		}
	}
	

	@RequestMapping(value="/deleteuser")
	@ResponseBody
	public String delete(int userid){
		System.out.println("delete");
		int row=userService.removeUser(userid);
		if(row>0)
			return "success";
		else
			return "error";
	}
	
	//登录后台界面
	@RequestMapping(value="/backstage")
	public String backuser(){
		return "backstage";
	}
	//登录用户管理页
	@RequestMapping(value="/backuser")
	public String backuser1(){
		return "backuser";
	}
	//进入公告管理页
	@RequestMapping(value="/intoNotice")
	public String intoNotice(){
		return "notice";
	}
	//进入帖子管理页
	@RequestMapping(value="/intoPostManager")
	public String intoPostManager(){
		return "post";
	}
	
	@RequestMapping("/inputIcon")
    @ResponseBody
    public Map<String, Object> updatePhoto(HttpSession session,@RequestParam("txt_file") MultipartFile myFile){
        Map<String, Object> json = new HashMap<String, Object>();
        try {
        	System.out.println("changeUserImg!!");
        	String filename=myFile.getOriginalFilename();
        	//后缀名转小写
        	String sub=filename.substring(filename.indexOf(".")+1);//获取后缀
        	sub=sub.toLowerCase();//转小写
        	filename=filename.substring(0, filename.indexOf("."));//获取文件名称
        	filename=new Date().getTime()+filename+"."+sub;//拼接保存名称
            String path="img/user/"+filename;
            //更新用户图片地址
        	User myuser=(User)session.getAttribute("user");
        	User user=userService.loadUserByUserid(myuser.getUserid());
        	user.setHead(path);
        	userService.saveUser(user);
        	session.setAttribute("user", user);
            /*
             * 图片保存在本地，然后Tomcat配置虚拟映射
             * <Context docBase="真实地址url" path="虚拟地址lnsfBBS/path" reloadable="true"/>
             */
            String url = "C:\\tomcat7.0.42\\mappingFolder";
            System.out.println(url);
            //相对路径
            //String path = "/"+name + "." + ext;
            File file = new File(url,filename);
            if(!file.exists()){
                file.mkdirs();
            }
            myFile.transferTo(file);
            json.put("success", path);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return json ;

    }
	
	@RequestMapping(value="/searchUser",method=RequestMethod.GET)
	@ResponseBody
	public Map<String, Object> searchUser(String petname,int page,int rows,HttpServletRequest request){
		Map<String, Object> map=new HashMap<String, Object>();
		Page<User> page2=userService.loadUserPageByPetnameLike(petname, page, rows);
		int pageCount=page2.getTotalPages();
		List<User> users=page2.getContent();
		map.put("total", pageCount);
		map.put("rows", users);
		return map;
	}
}

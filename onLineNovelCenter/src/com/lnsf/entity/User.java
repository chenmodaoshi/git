package com.lnsf.entity;

/**
 * 修改人：卢仲贤
 * 日期：2017/7/28
 */



import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.mysql.jdbc.Util;

@Entity
@Table(name="users")
public class User {
	private Integer userid;		//用户id，主键，自增
	private String accound;		//账号，not null
	private String pwd;			//密码，not null
	private Integer pow;		//权限，not null，0/坛主/1管理员/2用户，不在表中：游客
	private Date regdate;		//注册时间，not null，到日
	private String sex;			//性别，not null，男或女
	private String petname;		//昵称，not null
	private String Phone;		//手机号，找回密码用，not null
	private String head;        //头像
	private Integer status;		//状态，0允许回复/1禁止回复
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="seq_uid")
	@SequenceGenerator(allocationSize=1,name="seq_uid",sequenceName="seq_uid" )
	public Integer getUserid() {
		return userid;
	}
	public void setUserid(Integer userid) {
		this.userid = userid;
	}
	@Column(nullable=false,length=30,unique=true)
	public String getAccound() {
		return accound;
	}
	public void setAccound(String accound) {
		this.accound = accound;
	}
	@Column(nullable=false,length=30)
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
	@Column(nullable=false,columnDefinition="number(2) default 2")
	public Integer getPow() {
		return pow;
	}
	public void setPow(Integer pow) {
		this.pow = pow;
	}
	@Column(nullable=false)
	@Temporal(TemporalType.DATE)
	public Date getRegdate() {
		return regdate;
	}
	public void setRegdate(Date regdate) {
		this.regdate = regdate;
	}
	@Column(nullable=false,length=10)
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	@Column(nullable=false,length=20)
	public String getPetname() {
		return petname;
	}
	public void setPetname(String petname) {
		this.petname = petname;
	}
	@Column(nullable=false,length=2)
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	@Column(nullable=false,length=11)
	public String getPhone() {
		return Phone;
	}
	public void setPhone(String phone) {
		Phone = phone;
	}
	@Column(nullable=false,length=100)
	public String getHead() {
		return head;
	}
	public void setHead(String head) {
		this.head = head;
	}
	public User(Integer userid, String accound, String pwd, Integer pow,
			Date regdate, String sex, String petname, String phone,
			String head, Integer status) {
		super();
		this.userid = userid;
		this.accound = accound;
		this.pwd = pwd;
		this.pow = pow;
		this.regdate = regdate;
		this.sex = sex;
		this.petname = petname;
		Phone = phone;
		this.head = head;
		this.status = status;
	}
	public User() {
		super();
	}
	@Override
	public String toString() {
		return "User [userid=" + userid + ", accound=" + accound + ", pwd="
				+ pwd + ", pow=" + pow + ", regdate=" + regdate + ", sex="
				+ sex + ", petname=" + petname + ", Phone=" + Phone + ", head="
				+ head + ", status=" + status + "]";
	}
	
	
	
}

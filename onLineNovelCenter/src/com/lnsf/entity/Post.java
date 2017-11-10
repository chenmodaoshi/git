package com.lnsf.entity;
/**
 * 修改人：卢仲贤
 * 日期：2017/7/28
 */
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="post")
public class Post {
	private Integer postid;			//贴id，主键，自增
	private String pname;			//贴名，not null
	private User user;				//贴主编号，FK
	private Date createdate;		//创建时间，not null，到日
	private String ptype;			//贴属性，not null
	private Integer plevel;			//贴等级，not null，0置顶/1精华/2普通
	private Date lastdate;			//最后评论时间，not null，用于排序，到秒
	private Integer maxfloor;		//最大楼层，not null
	private Integer commnum;
	private Integer clicknum;
	
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="seq_bid")
	@SequenceGenerator(name="seq_bid",allocationSize=1,sequenceName="seq_bid")
	public Integer getPostid() {
		return postid;
	}
	public void setPostid(Integer postid) {
		this.postid = postid;
	}
	@Column(nullable=false,length=300)
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	@ManyToOne
	@JoinColumn(name="userid",nullable=false)
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	@Column(nullable=false)
	@Temporal(TemporalType.DATE)
	public Date getCreatedate() {
		return createdate;
	}
	public void setCreatedate(Date createdate) {
		this.createdate = createdate;
	}
	@Column(nullable=false,length=24)
	public String getPtype() {
		return ptype;
	}
	public void setPtype(String ptype) {
		this.ptype = ptype;
	}
	@Column(nullable=false,length=3)
	public Integer getPlevel() {
		return plevel;
	}
	public void setPlevel(Integer plevel) {
		this.plevel = plevel;
	}
	@Column(nullable=false)
	@Temporal(TemporalType.TIMESTAMP)
	public Date getLastdate() {
		return lastdate;
	}
	public void setLastdate(Date lastdate) {
		this.lastdate = lastdate;
	}
	@Column(nullable=false)
	public Integer getMaxfloor() {
		return maxfloor;
	}
	public void setMaxfloor(Integer maxfloor) {
		this.maxfloor = maxfloor;
	}
	@Column(nullable=false,columnDefinition="number default 0")
	public Integer getCommnum() {
		return commnum;
	}
	public void setCommnum(Integer commnum) {
		this.commnum = commnum;
	}
	@Column(nullable=false,columnDefinition="number default 0")
	public Integer getClicknum() {
		return clicknum;
	}
	public void setClicknum(Integer clicknum) {
		this.clicknum = clicknum;
	}
	public Post(Integer postid, String pname, User user, Date createdate, String ptype, Integer plevel, Date lastdate,
			Integer maxfloor, Integer commnum, Integer clicknum) {
		super();
		this.postid = postid;
		this.pname = pname;
		this.user = user;
		this.createdate = createdate;
		this.ptype = ptype;
		this.plevel = plevel;
		this.lastdate = lastdate;
		this.maxfloor = maxfloor;
		this.commnum = commnum;
		this.clicknum = clicknum;
	}
	public Post() {
		super();
	}
	@Override
	public String toString() {
		return "Post [postid=" + postid + ", pname=" + pname + ", user=" + user + ", createdate=" + createdate
				+ ", ptype=" + ptype + ", plevel=" + plevel + ", lastdate=" + lastdate + ", maxfloor=" + maxfloor
				+ ", commnum=" + commnum + ", clicknum=" + clicknum + "]";
	}
}

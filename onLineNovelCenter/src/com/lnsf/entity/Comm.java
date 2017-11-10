package com.lnsf.entity;
/**
 * 修改人：卢仲贤
 * 日期：2017/7/28
 */
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
@Entity
@Table(name="comm")
public class Comm {
	private Integer commid;		//评论id，主键，自增
	private User user;			//发评论用户id，FK
	private Post post;			//所属贴子id，FK
	private Integer floor;		//楼层数，not null，用于帖子里排序
	private String content;		//贴内容，not nul
	private List<Comm> parent;		//父母评论id，若为null，则为评论，若不为null，则为回复
	private Date pubdate;		//发布时间，not null ，到秒
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="seq_cid")
	@SequenceGenerator(allocationSize=1,name="seq_cid",sequenceName="seq_cid")
	public Integer getCommid() {
		return commid;
	}
	public void setCommid(Integer commid) {
		this.commid = commid;
	}
	@ManyToOne
	@JoinColumn(name="userid" , nullable=false)
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	@ManyToOne
	@JoinColumn(name="postid" , nullable=false)
	public Post getPost() {
		return post;
	}
	public void setPost(Post post) {
		this.post = post;
	}
	@Column(nullable=false)
	public Integer getFloor() {
		return floor;
	}
	public void setFloor(Integer floor) {
		this.floor = floor;
	}
	@Column(nullable=false,length=2400)
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@OneToMany(fetch=FetchType.EAGER,cascade= {CascadeType.REMOVE})
	@JoinColumn(name="parent")
	public List<Comm> getParent() {
		return parent;
	}
	public void setParent(List<Comm> parent) {
		this.parent = parent;
	}
	@Column(nullable=false)
	@Temporal(TemporalType.TIMESTAMP)
	public Date getPubdate() {
		return pubdate;
	}
	public void setPubdate(Date pubdate) {
		this.pubdate = pubdate;
	}
	public Comm(Integer commid, User user, Post post, Integer floor, String content, List<Comm> parent, Date pubdate) {
		super();
		this.commid = commid;
		this.user = user;
		this.post = post;
		this.floor = floor;
		this.content = content;
		this.parent = parent;
		this.pubdate = pubdate;
	}
	public Comm() {
		super();
	}
	@Override
	public String toString() {
		return "Comm [commid=" + commid + ", parent=" + parent + "]";
	}
	
	
	
}

package com.lnsf.util;

import java.util.Comparator;

import com.lnsf.entity.Comm;

public class CommComparatpor implements Comparator<Comm> {

	@Override
	public int compare(Comm o1, Comm o2) {
		return o1.getFloor()-o2.getFloor();
	}

}

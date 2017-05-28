package com.bootstrap.util;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.sql.rowset.CachedRowSet;
import com.sun.rowset.CachedRowSetImpl;

public class DBUtil {
	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@115.159.224.212:1521:orcl";
	private static final String USERNAME = "scott";
	private static final String PASSWORD = "159753";

	/**
	 * 连接数据库
	 * 
	 * @return
	 */
	public static Connection getConn() {
		Connection conn = null;
		// 注册驱动
		try {
			Class.forName(DRIVER);
			conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return conn;
	}

	/**
	 * 执行增删改
	 */

	public static int execUpdate(String sql, Object... params) {
		int count = 0;
		// 获取数据库连接对象
		Connection conn = getConn();
		// 产生prepareStatement
		PreparedStatement pstm = null;
		try {
			pstm = conn.prepareStatement(sql);
			if (params != null) {
				for (int i = 0; i < params.length; i++) {
					pstm.setObject(i + 1, params[i]);
				}
				count = pstm.executeUpdate();
			}

		} catch (SQLException e) {

			e.printStackTrace();
		}finally{
			closeAll(null,  pstm,conn);
		}
		return count;
	}

	
	//很多情况我们使用ResultSet 就会因为这样那样的问题，rs被关闭或数据链接被关闭，导致ResultSet不能使用。
		//其实这个问题我们可以用CachedRowSetImpl来解决。我的理解是这是一个结果的缓存类，保存在其中的数据不会随着数据库和ResultSet的连接的关闭而丢失，可以传递
		//public static CachedRowSet executeQuery(String sql, Object... params) {
	public static CachedRowSet execQuery(String sql, Object... params) {

		// ②获取连接对象 通过谁来获取连接对象?
		Connection conn = getConn();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		CachedRowSetImpl crs = null;

		try {

			crs = new CachedRowSetImpl();
			pstmt = conn.prepareStatement(sql);

			// insert into book(bookName,bookPrice,bookAuthor,typeId)
			// values(?,?,?,?)
			// 将? 补充完整(补齐)
			if (params != null)
				for (int i = 0; i < params.length; i++) {
					pstmt.setObject(i + 1, params[i]);
				}

			// .....
			// ⑤ 通过pstmt对象的方法得到一个结果集
			rs = pstmt.executeQuery();
			
			crs.populate(rs);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			// 释放资源的调用，如果么有结果集对象 使用null
			closeAll(rs, pstmt, conn);
		}

		return crs;
	}
	
	/**
	 *	执行无返回值的存储过程
	 * @param sql    存储过程名
	 * @param obj	存储过程参数
	 * @return		是否执行成功
	 */
	public static boolean noReturnvalProc(String sql,Object...obj){
		Connection conn=null;
		CallableStatement cs=null;
		try {
			conn=getConn();
			cs=conn.prepareCall("{call "+sql+"}");
			if(obj!=null){
				for (int i = 0; i < obj.length; i++) {
					cs.setObject(i+1, obj[i]);
				}
			}
			return cs.executeUpdate()>0;
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			closeAll(null,cs,conn);
		}
		return false;	
	}

	
	/**
	 * 关闭连接
	 */
    public static void closeAll(ResultSet rs, PreparedStatement pstm,	Connection conn){
    	if (null != rs)
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		if (null != pstm)
			try {
				pstm.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		if (null != conn)
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
    }
    
    
}

package cn.com.shxt.utils;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

/**
 * @author ccitKing  version 1.0
 */
public class DBUtil {
	
	private String url = "jdbc:mysql://localhost:3306/mingriyangguang";
	private String username = "root";
	private String password = "root";
	private Connection conn = null;
	private Statement stmt = null;
	private PreparedStatement pstmt = null;
	private ResultSet res = null;
	/**
	 * 静态代码块，加载驱动
	 */
	static {
		try {
			// 直连接的方式加载驱动
			 //Class.forName("com.mysql.jdbc.Driver"); 
			 // 池连接的方式加载驱动【要使用连接池，必须使用此种加载方式】
			  Class.forName("org.logicalcobwebs.proxool.ProxoolDriver");  
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
 
	/**
	 * 获取连接
	 * @return
	 */
	public Connection getConnection() { 
		try {
			
			//池连接获得连接的方式【要使用连接池，必须使用此种获得连接的方式,‘pageSysPro’为在proxool.xml中配置的连接池别名】
			 conn=DriverManager.getConnection("proxool.shxtPro");
			//直连接获得连接的方式
			 //conn = DriverManager.getConnection(url, username, password);
			return conn;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	
	/**
	 * 查询操作
	 * @param sql
	 * @return ResultSet ,需要调用者关闭连接
	 */
	public ResultSet query(String sql) {
		try {
			if (conn == null || conn.isClosed()) {
				conn = getConnection();
			}
			stmt = conn.createStatement();
			res = stmt.executeQuery(sql);
			return res;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		/**
		finally{
			res.close();
		}*/ //注意，此处不能关闭，若关闭了，则在调用的方法中无法得到数据
		return null;
	}


	/**
	 * 查询操作，使用PreparedStatement动态参数
	 * @param sql
	 * @param obj
	 * @return
	 */
	public ResultSet query(String sql, Object... obj) {
		try {
			if (conn == null || conn.isClosed()) {
				conn = getConnection();
			}
			pstmt = conn.prepareStatement(sql);
			for (int i = 0; i < obj.length; i++) {
				pstmt.setObject(i+1, obj[i]);
			}

			res = pstmt.executeQuery();
			return res;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 预处理语句查询结果并封装到List. 
	 * @param
	 * 	sql语句. 
	 * @param 可变参数. 
	 * @return
	 * 返回List. 
	 * @throws SQLException when the query execution failed.
	 */
	public List<Map<String, String>> queryBy_PreparedStatement(String query,String[] params) throws SQLException {
		ResultSet resultSet = null;
		List<Map<String, String>> result;
		try {
			 System.out.println("querySql: "+query);
			 
			pstmt =  getConnection().prepareStatement(query);
			if(params!=null){
			for (int i = 0; i < params.length; i++) {
				pstmt.setString(i + 1, params[i]);
			 }
			}
			resultSet = pstmt.executeQuery();
			result = new ArrayList<Map<String, String>>();
			while (resultSet.next()) {
				Map<String, String> rowMap = new HashMap<String, String>();
				for (int i = 1; i <= resultSet.getMetaData().getColumnCount(); i++) {
					rowMap.put(resultSet.getMetaData().getColumnLabel(i),
					        resultSet.getString(i));
				}
				result.add(rowMap);
			}
		} finally {
			this.close(); 
		}
		return result;
	}
	 
	/**
	 *  批量更新操作
	 *  @param sqlB
	 */
	public void updateByBatch(List<String> sqlB) {
		try {
			if (conn == null || conn.isClosed()) {
				conn = getConnection();
			}
			conn.setAutoCommit(false);                        // 设为非自动提交模式，利用事务进行批量操作

			stmt = conn.createStatement();
			for (int i = 0; i < sqlB.size(); i++) {
				stmt.addBatch(sqlB.get(i));
			}
			stmt.executeBatch();                              // 执行之后提交事务
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			try {
				conn.rollback();                               // 当出现异常时回滚事务
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		} finally {
			this.close();
		}
	}
	
	/**
	 * 批处理的方法 （多条sql语句是在同一事务下执行的）
	 * @param List<String> sqls 多条INSERT DELETE UPDATE	语句构成的集合 
	 */
	public void batchUpdate(List<String> sqls){
		System.out.println("执行批量更新");
		try{
			if (conn == null || conn.isClosed()) {
				conn = getConnection();
			}
			conn.setAutoCommit(false);                              //用事务进行批量操作
			stmt = conn.createStatement();
			for(int i=0;i<sqls.size();i++){
				stmt.addBatch(sqls.get(i));
			}
			stmt.executeBatch();
			conn.commit();                                           //执行之后提交事务
		}
		catch(Exception e){
			e.printStackTrace();
			try {
				//当出现异常时回滚事务
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		finally{
			close();
		}
	}
	 
	/**
	 * 批处理的方法 （多条sql语句是在同一事务下执行的）
	 * @param List<String> sqls 多条INSERT DELETE UPDATE	语句构成的集合 
	 */
	public void batchUpdate(String[] sqls){
		System.out.println("执行批量更新");
		try{
			if (conn == null || conn.isClosed()) {
				conn = getConnection();
			}
			conn.setAutoCommit(false);                              //用事务进行批量操作
			stmt = conn.createStatement();
			for(int i=0;i<sqls.length;i++){
				stmt.addBatch(sqls[i]); 
			}
			stmt.executeBatch();
			conn.commit();                                           //执行之后提交事务
		}
		catch(Exception e){
			e.printStackTrace();
			try {
				//当出现异常时回滚事务
				conn.rollback();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
		}
		finally{
			close();
		}
	}
	
	/**
	 *将结果集转成LinkedList集合，好处：不必关闭结果集
	 *同样可以读取图片到指定的位置
	 * @param sql
	 * @return
	 */
	public List<Map<String, String>> queryByList(String sql) {
		List<Map<String, String>> data = new LinkedList<Map<String, String>>();
		try {
			if (conn == null || conn.isClosed()) {
				conn = getConnection();
				stmt = conn.createStatement();
				res = stmt.executeQuery(sql);
				ResultSetMetaData rsmd = res.getMetaData();  
				int columnCount = rsmd.getColumnCount();
				String keyColumnName="";
				Map<String, String> map=null;
				String  value ="";
				while (res.next()) {
					map= new HashMap<String, String>();
					for (int i = 1; i <= columnCount; i++) {
					   keyColumnName=rsmd.getColumnLabel(i);  
					   value = res.getString(keyColumnName); 
							//""是可以被查出病赋值到RCP表中的，但是null就会出现空指针异常了，所有对Null值做如下处理：
							value=value==null?"":value;
							map.put(keyColumnName, value);	
					}
					 data.add(map);
					}
				
				}
				return data;
		 
		}catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally { 
			close();
		}
		return null;
	}

	
	/**
	 *将结果集转成LinkedList集合，好处：不必关闭结果集
	 *同样可以读取图片到指定的位置
	 * @param sql
	 * @return
	 */
	public List<Map<String, Object>> queryToList(String sql) {
		List<Map<String, Object>> data = new LinkedList<Map<String, Object>>();
		try {
			if (conn == null || conn.isClosed()) {
				conn = getConnection();
				stmt = conn.createStatement();
				res = stmt.executeQuery(sql);
				ResultSetMetaData rsmd = res.getMetaData();  
				int columnCount = rsmd.getColumnCount();
				while (res.next()) {
					Map<String, Object> map = new HashMap<String, Object>();
					for (int i = 1; i <= columnCount; i++) {
						//String keyColumnName = rsmd.getColumnName(i); //返回的是sql语句中field的原始名字 
						String keyColumnName=rsmd.getColumnLabel(i); //根据as后面的值当做列名
						Object value = null;
						//每一个字段的 数据类型
						int columnType = rsmd.getColumnType(i);
						//System.out.println("--------------类型：" + columnType);
						switch (columnType) {
						case java.sql.Types.BLOB:
							break;
						case java.sql.Types.LONGVARBINARY:    
							System.out.println("结果集中的第一个字段的值：  "+res.getString(1));
							
							String filename = new SimpleDateFormat(
									"yyyyMMddHHmmssSSS").format(new Date());
							File fileDirectory=new File("f:\\imageaa");
							if(!fileDirectory.isDirectory()){
								fileDirectory.mkdirs();//如果目录不存在，则创建该目录
							}
							File file = new File("f:\\imageaa\\" + filename
									+ ".jpg");
							System.out.println("文件名：" + filename);
							InputStream in = res.getBinaryStream(keyColumnName);
							FileOutputStream fos = new FileOutputStream(file);
							byte[] dataArray = new byte[512];
							int length;
							while ((length = in.read(dataArray, 0,
									dataArray.length)) != -1) {
								fos.write(dataArray, 0, length);
							}
							fos.flush();
							fos.close();
							in.close();
							break;
						case java.sql.Types.CHAR:
							value = res.getString(keyColumnName);
							break;
						default:
							value = res.getObject(keyColumnName);
							//解决数据库中查出的数据为“”或null的空指针情况，什么情况是null,什么情况是“”
							//解决：实验证明，当不想数据库中填充数据时默认varchar类型为null,当填充数据后又将数据删除后，该字段值就变成了“”
							//""是可以被查出病赋值到RCP表中的，但是null就会出现空指针异常了，所有对Null值做如下处理：
							value=value==null?"":value;
						}
						map.put(keyColumnName, value);
					}
					data.add(map);
				}
				return data;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return null;
	}

	
	/**
	 *将结果集转成LinkedList集合，好处：不必关闭结果集
	 *同样可以读取图片到指定的位置
	 * @param sql
	 * @return
	 */
	/**
	 * 查询操作，使用PreparedStatement动态参数
	 * @param sql
	 * @param obj
	 * @return
	 */
	/*public ResultSet query(String sql, Object... obj) {
		try {
			if (conn == null || conn.isClosed()) {
				conn = getConnection();
			}
			pstmt = conn.prepareStatement(sql);
			for (int i = 0; i < obj.length; i++) {
				pstmt.setObject(i+1, obj[i]);
			}

			res = pstmt.executeQuery();
			return res;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}*/
	public List<Map<String, Object>> queryToListByPareparedStatement(String sql, Object... obj) {
		List<Map<String, Object>> data = new LinkedList<Map<String, Object>>();
		try {
			if (conn == null || conn.isClosed()) {
				conn = getConnection();
				pstmt = conn.prepareStatement(sql);
				for (int i = 0; i < obj.length; i++) {
					pstmt.setObject(i+1, obj[i]);
				}
				System.out.println("queryToListByPareparedStatement :  "+sql);
				res = pstmt.executeQuery();
				ResultSetMetaData rsmd = res.getMetaData();  
				int columnCount = rsmd.getColumnCount();
				while (res.next()) {
					Map<String, Object> map = new HashMap<String, Object>();
					for (int i = 1; i <= columnCount; i++) {
						//String keyColumnName = rsmd.getColumnName(i); //返回的是sql语句中field的原始名字 
						String keyColumnName=rsmd.getColumnLabel(i); //根据as后面的值当做列名
						Object value = null;
						//每一个字段的 数据类型
						int columnType = rsmd.getColumnType(i);
						//System.out.println("--------------类型：" + columnType);
						switch (columnType) {
						case java.sql.Types.BLOB:
							break;
						case java.sql.Types.LONGVARBINARY:    
							System.out.println("结果集中的第一个字段的值：  "+res.getString(1));
							
							String filename = new SimpleDateFormat(
									"yyyyMMddHHmmssSSS").format(new Date());
							File fileDirectory=new File("f:\\imageaa");
							if(!fileDirectory.isDirectory()){
								fileDirectory.mkdirs();//如果目录不存在，则创建该目录
							}
							File file = new File("f:\\imageaa\\" + filename
									+ ".jpg");
							System.out.println("文件名：" + filename);
							InputStream in = res.getBinaryStream(keyColumnName);
							FileOutputStream fos = new FileOutputStream(file);
							byte[] dataArray = new byte[512];
							int length;
							while ((length = in.read(dataArray, 0,
									dataArray.length)) != -1) {
								fos.write(dataArray, 0, length);
							}
							fos.flush();
							fos.close();
							in.close();
							break;
						case java.sql.Types.CHAR:
							value = res.getString(keyColumnName);
							break;
						default:
							value = res.getObject(keyColumnName);
							//解决数据库中查出的数据为“”或null的空指针情况，什么情况是null,什么情况是“”
							//解决：实验证明，当不想数据库中填充数据时默认varchar类型为null,当填充数据后又将数据删除后，该字段值就变成了“”
							//""是可以被查出病赋值到RCP表中的，但是null就会出现空指针异常了，所有对Null值做如下处理：
							value=value==null?"":value;
						}
						map.put(keyColumnName, value);
					}
					data.add(map);
				}
				return data;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return null;
	}
	
	/**
	 * 更新操作：增、删、改（返回影响行数）
	 * @param sql
	 * @return
	 */
	public int update(String sql) {
		try {
			if (conn == null || conn.isClosed()) {
				conn = getConnection();
			}
			stmt = conn.createStatement();
			return stmt.executeUpdate(sql);
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			close();
		}

		return 0;
	}

	/**
	 *更新操作：使用PreparedStatement操作参数，增、删、改（返回影响行数）
	 *当然，可以上传图片 
	 * @param sql
	 * @param obj
	 * @return
	 */
	public int update(String sql, Object... obj) {
		try {
			if (conn == null || conn.isClosed()) {
				conn = getConnection();
			}
			pstmt = conn.prepareStatement(sql);
			if(obj!=null){
			for (int i = 0; i < obj.length; i++) {
				if (obj[i] instanceof File) {
					File file = (File) obj[i];
					FileInputStream in = new FileInputStream(file);
					pstmt.setBinaryStream(i + 1, in, (int) file.length());
					continue;
				}
				pstmt.setObject(i + 1, obj[i]);  
			}
			}
			return pstmt.executeUpdate();
		} catch (SQLException e) {

			e.printStackTrace();
		} catch (FileNotFoundException e) {
			System.out.println("找不到文件");
			e.printStackTrace();
		} finally {
			close();
		}
		return 0;
	}

	
	/**
	 * 更新操作：使用PreparedStatement操作参数，增、删、改（返回影响行数）
	 * @param sql
	 * @param obj
	 * @return
	 */
	public int update(String sql, List obj) {
		try {
			if (conn == null || conn.isClosed()) {
				conn = getConnection();
			}
			pstmt = conn.prepareStatement(sql);
			for (int i = 0; i < obj.size(); i++) {
				pstmt.setObject(i + 1, obj.get(i));                       // setString()有缺陷,改为setObject()

			}
			return pstmt.executeUpdate();
		} catch (SQLException e) {

			e.printStackTrace();
		} finally {
			close();
		}

		return 0;
	}

	 
	/**
	 * 关闭资源
	 */
	public void close() {
		if (res != null) {                               // 关闭结果集
			try {
				res.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (stmt != null) {                               // 关闭语句对象
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (pstmt != null) {
			try {
				pstmt.close();                           // 关闭PreparedStatem预编译的 SQL 语句的对象。

			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {                              // 关闭连接
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	/**
	 * 主测试方法
	 * @param args
	 */
	 public static void main(String[] args) {
		DBUtil dbUtil=new DBUtil();
		
		//向数据库中插入指定的图片
		String sql=" INSERT  INTO fileinfo (fileinfo) VALUES(?) " ; 
		Object[] param1=new Object[1];
		File imgFile=new File("d://boy1.jpg");
		param1[0]=imgFile;
		dbUtil.update(sql, param1);
		
		
		//queryToList
		String sql2=" select * from  fileinfo  where id=3";
		List<Map<String, Object>> list=dbUtil.queryToList(sql2);
		 
//		int  res=dbUtil.update("  INSERT INTO  userinfo  (username,PASSWORD) VALUES('hanjinda','123123')   ");
//		System.out.println(res);
	}

}

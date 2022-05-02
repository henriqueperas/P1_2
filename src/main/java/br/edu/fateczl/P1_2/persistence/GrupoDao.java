package br.edu.fateczl.P1_2.persistence;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import br.edu.fateczl.P1_2.model.Grupo;
import br.edu.fateczl.P1_2.model.Time;

@Repository
public class GrupoDao implements IGrupoDao {
	
	@Autowired
	GenericDao gDao;

	@Override
	public String separaGrupos() throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();

		String sql = "CALL sp_separa_grupos (?)";
		CallableStatement cs = c.prepareCall(sql);
		cs.registerOutParameter(1, Types.VARCHAR);
		cs.execute();
		
		String gera = cs.getString(1);
		
		cs.close();
		c.close();
		return gera;
	}

	@Override
	public List<Grupo> listaGrupos() throws SQLException, ClassNotFoundException {
		List<Grupo> grupos  = new ArrayList<Grupo>();
		
		Connection c = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM grupos");
		
		PreparedStatement ps = c.prepareStatement(sql.toString());

		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Time t = new Time();
			Grupo g = new Grupo();
			t.setCodigo_T(rs.getInt("codigoTimeG"));
			g.setTime(t);
			g.setCodigo(rs.getInt("codigoGrupo"));
			
			g.setGrupo(rs.getString("grupo"));
			
			grupos.add(g);
		}
		rs.close();
		ps.close();
		c.close();
		return grupos;
	}

	@Override
	public List<Grupo> listaGrupo(String letra) throws SQLException, ClassNotFoundException {
		List<Grupo> grupo = new ArrayList<Grupo>();
		
		Connection c = gDao.getConnection();
		StringBuffer sql = new StringBuffer();
		sql.append("SELECT * FROM grupos WHERE grupo = ?");
		
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setString(1, letra);
		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Time t = new Time();
			Grupo g = new Grupo();
			t.setCodigo_T(rs.getInt("codigoTimeG"));
			g.setTime(t);
			g.setCodigo(rs.getInt("codigoGrupo"));
			
			g.setGrupo(rs.getString("grupo"));
			
			grupo.add(g);
			
		}
		rs.close();
		ps.close();
		c.close();
		return grupo;

	}

}
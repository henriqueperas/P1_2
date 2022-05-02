package br.edu.fateczl.P1_2.persistence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import br.edu.fateczl.P1_2.model.FinalRebaixamento;
import br.edu.fateczl.P1_2.model.GrupoPontos;

@Repository
public class SeparacoesDao implements ISeparacoesDao{
	
	@Autowired
	GenericDao gDao;

	@Override
	public List<GrupoPontos> listaGrupoEPontos(String grupo) throws ClassNotFoundException, SQLException {
		List<GrupoPontos> grop = new ArrayList<GrupoPontos>();
		
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM dbo.fn_grupo('?')";
		PreparedStatement ps = c.prepareStatement(sql);
		ps.setString(1, grupo);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			GrupoPontos gp = new GrupoPontos();
			gp.setNome(rs.getString("nome"));
			gp.setPartidas(rs.getInt("partidas"));
			gp.setVitorias(rs.getInt("vitorias"));
			gp.setEmpates(rs.getInt("empates"));
			gp.setDerrotas(rs.getInt("derrotas"));
			gp.setGols_marcados(rs.getInt("gols_marcados"));
			gp.setGols_sofridos(rs.getInt("gols_sofridos"));
			gp.setSaldo_gols(rs.getInt("saldo_gols"));
			gp.setPontos(rs.getInt("pontos"));
			
			grop.add(gp);
		}
		
		rs.close();
		ps.close();
		c.close();
		return grop;
	}
	
	@Override
	public List<GrupoPontos> listaCampeonato() throws ClassNotFoundException, SQLException {
		List<GrupoPontos> grop = new ArrayList<GrupoPontos>();
		
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM dbo.fn_campeonato()";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			GrupoPontos gp = new GrupoPontos();
			gp.setNome(rs.getString("nome"));
			gp.setPartidas(rs.getInt("partidas"));
			gp.setVitorias(rs.getInt("vitorias"));
			gp.setEmpates(rs.getInt("empates"));
			gp.setDerrotas(rs.getInt("derrotas"));
			gp.setGols_marcados(rs.getInt("gols_marcados"));
			gp.setGols_sofridos(rs.getInt("gols_sofridos"));
			gp.setSaldo_gols(rs.getInt("saldo_gols"));
			gp.setPontos(rs.getInt("pontos"));
			
			grop.add(gp);
		}
		
		rs.close();
		ps.close();
		c.close();
		return grop;
	}

	@Override
	public List<FinalRebaixamento> listaRebaixamento() throws ClassNotFoundException, SQLException {
		List<FinalRebaixamento> fire = new ArrayList<FinalRebaixamento>();
		
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM dbo.fn_rebaixamento()";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			FinalRebaixamento fr = new FinalRebaixamento();
			fr.setNome(rs.getString("nome"));
			fire.add(fr);
		}
		
		rs.close();
		ps.close();
		c.close();
		return fire;
	}

	@Override
	public List<FinalRebaixamento> listaQuartasFinal() throws ClassNotFoundException, SQLException {
		List<FinalRebaixamento> fire = new ArrayList<FinalRebaixamento>();
		
		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM dbo.fn_quartas_final()";
		PreparedStatement ps = c.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			FinalRebaixamento fr = new FinalRebaixamento();
			fr.setNome(rs.getString("nome"));
			fire.add(fr);
		}
		
		rs.close();
		ps.close();
		c.close();
		return fire;
	}

	@Override
	public void InsereGols(int time1, int gols1, int time2, int gols2) throws SQLException, ClassNotFoundException {
		Connection c = gDao.getConnection();
		String sql = "UPDATE jogos SET golsTime1 = ?, golsTime2 = ? WHERE codigoTime1 = ? AND codigoTime2 = ?";

		PreparedStatement ps = c.prepareStatement(sql);
		ps.setInt(1, gols1);
		ps.setInt(2, gols2);
		ps.setInt(3, time1);
		ps.setInt(4, time2);

		ps.execute();
		ps.close();
		c.close();
		
	}

}

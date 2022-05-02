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

import br.edu.fateczl.P1_2.model.Jogo;
import br.edu.fateczl.P1_2.model.Time;

@Repository
public class PartidasDao implements IPartidasDao {

	@Autowired
	GenericDao gDao;

	@Override
	public String geraPartida() throws SQLException, ClassNotFoundException {
		Connection con = gDao.getConnection();

		String sql = "CALL sp_cria_partidas (?)";
		CallableStatement cs = con.prepareCall(sql);
		cs.registerOutParameter(1, Types.VARCHAR);
		cs.execute();

		String saida = cs.getString(1);

		cs.close();
		con.close();
		return saida;
	}

	@Override
	public List<Jogo> listaPartida(String data) throws SQLException, ClassNotFoundException {
		List<Jogo> jogos = new ArrayList<Jogo>();

		Connection c = gDao.getConnection();
		String sql = "SELECT * FROM jogos WHERE data_jogo = ?";
		
		PreparedStatement ps = c.prepareStatement(sql.toString());
		ps.setString(1, data);

		ResultSet rs = ps.executeQuery();
		while (rs.next()) {
			Jogo j = new Jogo();
			Time time1 = new Time();
			Time time2 = new Time();
			j.setCodigoJogo(rs.getInt("codigoJogo"));
			time1.setCodigoTime(rs.getInt("codTA"));
			
			time2.setCodigoTime(rs.getInt("codTB"));
			
			j.setTime1(time1);
			j.setTime2(time2);
			j.setGolsTime1(rs.getInt("golsTimeA"));
			j.setGolsTime2(rs.getInt("golsTimeB"));
			j.setDataJogo(rs.getString("datas"));

			jogos.add(j);
		}
		return jogos;
	}

}
package br.edu.fateczl.P1_2.persistence;

import java.sql.SQLException;
import java.util.List;

import br.edu.fateczl.P1_2.model.Jogo;

public interface IPartidasDao {

	public String geraPartida() throws SQLException, ClassNotFoundException;
	public List<Jogo> listaPartida(String data) throws SQLException, ClassNotFoundException;
}

package br.edu.fateczl.P1_2.persistence;

import java.sql.SQLException;
import java.util.List;

import br.edu.fateczl.P1_2.model.FinalRebaixamento;
import br.edu.fateczl.P1_2.model.GrupoPontos;
import br.edu.fateczl.P1_2.model.Jogo;

public interface ISeparacoesDao {

	public List<GrupoPontos> listaGrupoEPontos(String grupo) throws ClassNotFoundException, SQLException;
	public void InsereGols(int time1, int golsTime1, int time2, int golsTime2) throws SQLException, ClassNotFoundException;
	public List<GrupoPontos> listaCampeonato() throws ClassNotFoundException, SQLException;
	public List<FinalRebaixamento> listaRebaixamento() throws ClassNotFoundException, SQLException;
	public List<FinalRebaixamento> listaQuartasFinal() throws ClassNotFoundException, SQLException;
}

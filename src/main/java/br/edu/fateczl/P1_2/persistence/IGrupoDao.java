package br.edu.fateczl.P1_2.persistence;

import java.sql.SQLException;
import java.util.List;

import br.edu.fateczl.P1_2.model.Grupo;

public interface IGrupoDao {
	
	public String separaGrupos() throws ClassNotFoundException, SQLException;
	public List<Grupo> listaGrupos() throws ClassNotFoundException, SQLException;
	public List<Grupo> listaGrupo(String letra) throws ClassNotFoundException, SQLException;
}

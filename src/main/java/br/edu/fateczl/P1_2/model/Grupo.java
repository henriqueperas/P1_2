package br.edu.fateczl.P1_2.model;

public class Grupo {
	private Time time;
	
	private int codigo;
	private String grupo;
	public Time getTime() {
		return time;
	}
	public void setTime(Time time) {
		this.time = time;
	}
	public int getCodigo() {
		return codigo;
	}
	public void setCodigo(int codigo) {
		this.codigo = codigo;
	}
	public String getGrupo() {
		return grupo;
	}
	public void setGrupo(String grupo) {
		this.grupo = grupo;
	}
	@Override
	public String toString() {
		return "Grupo [time=" + time + ", codigo=" + codigo + ", grupo=" + grupo + "]";
	}
	
}

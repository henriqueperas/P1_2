package br.edu.fateczl.P1_2.model;

public class Time {
	private int codigo_T;
	private String nomeTime;
	private String cidade;
	private String estadio;
	public int getCodigo_T() {
		return codigo_T;
	}
	public void setCodigo_T(int codigo_T) {
		this.codigo_T = codigo_T;
	}
	public String getNomeTime() {
		return nomeTime;
	}
	public void setNomeTime(String nomeTime) {
		this.nomeTime = nomeTime;
	}
	public String getCidade() {
		return cidade;
	}
	public void setCidade(String cidade) {
		this.cidade = cidade;
	}
	public String getEstadio() {
		return estadio;
	}
	public void setEstadio(String estadio) {
		this.estadio = estadio;
	}
	@Override
	public String toString() {
		return "Time [codigo_T=" + codigo_T + ", nomeTime=" + nomeTime + ", cidade=" + cidade + ", estadio=" + estadio
				+ "]";
	}
}
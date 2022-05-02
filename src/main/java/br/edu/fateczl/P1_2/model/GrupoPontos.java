package br.edu.fateczl.P1_2.model;

public class GrupoPontos {
	private String nome;
	private int partidas;
	private int vitorias;
	private int empates;
	private int derrotas;
	private int gols_marcados;
	private int gols_sofridos;
	private int saldo_gols;
	private int pontos;
	
	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public int getPartidas() {
		return partidas;
	}
	public void setPartidas(int partidas) {
		this.partidas = partidas;
	}
	public int getVitorias() {
		return vitorias;
	}
	public void setVitorias(int vitorias) {
		this.vitorias = vitorias;
	}
	public int getEmpates() {
		return empates;
	}
	public void setEmpates(int empates) {
		this.empates = empates;
	}
	public int getDerrotas() {
		return derrotas;
	}
	public void setDerrotas(int derrotas) {
		this.derrotas = derrotas;
	}
	public int getGols_marcados() {
		return gols_marcados;
	}
	public void setGols_marcados(int gols_marcados) {
		this.gols_marcados = gols_marcados;
	}
	public int getGols_sofridos() {
		return gols_sofridos;
	}
	public void setGols_sofridos(int gols_sofridos) {
		this.gols_sofridos = gols_sofridos;
	}
	public int getSaldo_gols() {
		return saldo_gols;
	}
	public void setSaldo_gols(int saldo_gols) {
		this.saldo_gols = saldo_gols;
	}
	public int getPontos() {
		return pontos;
	}
	public void setPontos(int pontos) {
		this.pontos = pontos;
	}
	
	@Override
	public String toString() {
		return "GrupoPontos [nome=" + nome + ", partidas=" + partidas + ", vitorias=" + vitorias + ", empates="
				+ empates + ", derrotas=" + derrotas + ", gols_marcados=" + gols_marcados + ", gols_sofridos="
				+ gols_sofridos + ", saldo_gols=" + saldo_gols + ", pontos=" + pontos + "]";
	}
}

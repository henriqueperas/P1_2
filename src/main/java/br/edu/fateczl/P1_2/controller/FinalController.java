package br.edu.fateczl.P1_2.controller;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import br.edu.fateczl.P1_2.model.FinalRebaixamento;
import br.edu.fateczl.P1_2.model.GrupoPontos;
import br.edu.fateczl.P1_2.persistence.SeparacoesDao;

@Controller
public class FinalController {
	
	@Autowired
	SeparacoesDao sDao;

	@RequestMapping(name = "final", value = "/final", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("final");
	}
	
	@RequestMapping(name = "final", value = "/final", method = RequestMethod.POST)
	public ModelAndView grupos(ModelMap model, 
			@RequestParam Map<String, String> allParam) {
		String botao = allParam.get("botao");
		List<GrupoPontos> grupoA = new ArrayList<GrupoPontos>();
		List<GrupoPontos> grupoB = new ArrayList<GrupoPontos>();
		List<GrupoPontos> grupoC = new ArrayList<GrupoPontos>();
		List<GrupoPontos> grupoD = new ArrayList<GrupoPontos>();
		List<GrupoPontos> todos = new ArrayList<GrupoPontos>();
		String erro = "";
		String saida = "";
		try {
			if(botao.contains("grupo")) {
				grupoA = sDao.listaGrupoEPontos("A");
				grupoB = sDao.listaGrupoEPontos("B");
				grupoC = sDao.listaGrupoEPontos("C");
				grupoD = sDao.listaGrupoEPontos("D");
			}
			if(botao.contains("todos")) {
				todos = sDao.listaCampeonato();
			}
		}catch(SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			model.addAttribute("grupoA", grupoA);
			model.addAttribute("grupoB", grupoB);
			model.addAttribute("grupoC", grupoC);
			model.addAttribute("grupoD", grupoD);
			model.addAttribute("todos", todos);
		}
		return new ModelAndView("final");
	}
}

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

import br.edu.fateczl.P1_2.model.GrupoPontos;
import br.edu.fateczl.P1_2.persistence.SeparacoesDao;

@Controller
public class QuartasController {
	
	@Autowired
	SeparacoesDao sDao;

	@RequestMapping(name = "quartas", value = "/quartas", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("quartas");
	}

	@RequestMapping(name = "quartas", value = "/quartas", method = RequestMethod.POST)
	public ModelAndView grupos(ModelMap model, 
			@RequestParam Map<String, String> allParam) {
		String erro = "";
		List<GrupoPontos> grupoA = new ArrayList<GrupoPontos>();
		List<GrupoPontos> grupoB = new ArrayList<GrupoPontos>();
		List<GrupoPontos> grupoC = new ArrayList<GrupoPontos>();
		List<GrupoPontos> grupoD = new ArrayList<GrupoPontos>();
		
		try {
			grupoA = sDao.listaGrupoEPontos("A");
			grupoB = sDao.listaGrupoEPontos("B");
			grupoC = sDao.listaGrupoEPontos("C");
			grupoD = sDao.listaGrupoEPontos("D");
		} catch(ClassNotFoundException | SQLException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("grupoA", grupoA);
			model.addAttribute("grupoB", grupoB);
			model.addAttribute("grupoC", grupoC);
			model.addAttribute("grupoD", grupoD);
		}
		return new ModelAndView("quartas");
	}
}

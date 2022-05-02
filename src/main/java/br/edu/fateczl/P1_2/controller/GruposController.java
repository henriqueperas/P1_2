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

import br.edu.fateczl.P1_2.model.Grupo;
import br.edu.fateczl.P1_2.persistence.GrupoDao;

@Controller
public class GruposController {
	
	@Autowired
	GrupoDao grpDao;

	@RequestMapping(name = "grupo", value = "/grupo", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("grupo");
	}

	@RequestMapping(name = "grupo", value = "/grupo", method = RequestMethod.POST)
	public ModelAndView grupos(ModelMap model, 
			@RequestParam Map<String, String> allParam) {
		String erro = "";
		String gera = "";
		List<Grupo> grupos = new ArrayList<Grupo>();
		try {
			gera = grpDao.separaGrupos();
			grupos = listaGrupo();
		} catch(ClassNotFoundException | SQLException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("saida", gera);
			model.addAttribute("grupos", grupos);
		}
		return new ModelAndView("grupo");
	}
	
	private List<Grupo> listaGrupo() throws ClassNotFoundException, SQLException{
		List<Grupo> grupos = grpDao.listaGrupos();
		return grupos;
	}
}

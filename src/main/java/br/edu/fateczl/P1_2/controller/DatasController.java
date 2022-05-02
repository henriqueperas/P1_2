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

import br.edu.fateczl.P1_2.model.Jogo;
import br.edu.fateczl.P1_2.persistence.PartidasDao;
import br.edu.fateczl.P1_2.persistence.SeparacoesDao;

@Controller
public class DatasController {
	
	@Autowired
	PartidasDao pDao;
	
	@Autowired
	SeparacoesDao sDao;

	@RequestMapping(name = "datas", value = "/datas", method = RequestMethod.GET)
	public ModelAndView init(ModelMap model) {
		return new ModelAndView("datas");
	}

	@RequestMapping(name = "datas", value = "/datas", method = RequestMethod.POST)
	public ModelAndView grupos(ModelMap model, 
			@RequestParam Map<String, String> allParam) {
		String data = allParam.get("data_rodada");
		String botao = allParam.get("botao");
		String erro = "";
		String saida = "";
		
		List<Jogo> partida = new ArrayList<Jogo>();
		try {

			if(botao.equals("Pesquisar")) {
				partida = pDao.listaPartida(data);
				if(partida == null){
					saida = "Data inexistente";
				}
			}
			
			if(botao.equals("Atualizar")) {
				String time1 = allParam.get("time1");
				String gols1 = allParam.get("gols1");
				String time2 = allParam.get("time2");
				String gols2 = allParam.get("gols2");
				sDao.InsereGols(Integer.parseInt(time1), Integer.parseInt(gols1), Integer.parseInt(time2), Integer.parseInt(gols2));
				saida = "Os jogos foram atualizados";
			}
		}catch(SQLException | ClassNotFoundException e) {
			erro = e.getMessage();
		} finally {
			model.addAttribute("erro", erro);
			model.addAttribute("saida", saida);
			model.addAttribute("partida", partida);
		}
		return new ModelAndView("datas");
	}
	
}

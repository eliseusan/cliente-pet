package br.com.petz.clientepet.pet.application;

import java.util.UUID;

import javax.validation.Valid;

import org.springframework.stereotype.Service;

import lombok.extern.log4j.Log4j2;
@Service
@Log4j2
public class PetApplicationService implements PetService {

	@Override
	public PetResponse criaPet(UUID idCliente, @Valid PetRequest petRequest) {
		log.info("[inicia] PetApplicationService - criaPet");
		log.info("[finaliza] PetApplicationService - criaPet");
		return null;
	}

}

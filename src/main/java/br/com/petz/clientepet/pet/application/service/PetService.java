package br.com.petz.clientepet.pet.application.service;

import java.util.UUID;

import javax.validation.Valid;

import br.com.petz.clientepet.pet.application.PetRequest;
import br.com.petz.clientepet.pet.application.PetResponse;

public interface PetService {

	PetResponse criaPet(UUID idCliente, @Valid PetRequest petRequest);

}

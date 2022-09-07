package br.com.petz.clientepet.pet.application;

import java.util.UUID;

import javax.validation.Valid;

public interface PetService {

	PetResponse criaPet(UUID idCliente, @Valid PetRequest petRequest);

}

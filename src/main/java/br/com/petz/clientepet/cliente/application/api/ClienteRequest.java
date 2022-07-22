package br.com.petz.clientepet.cliente.application.api;

import java.time.LocalDate;
import java.util.UUID;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.br.CPF;

import br.com.petz.clientepet.cliente.domain.Sexo;
import lombok.Value;

@Value
public class ClienteRequest {

	@NotBlank
	private String nomeCompleto ;
	@NotBlank
	@Email
	private String email ;
	@NotBlank
	private String celular ;
	private String telefone ;
	private Sexo sexo ;
	@NotNull
	private LocalDate dataNacimento ;
	@CPF
	private String cpf ;
	@NotNull
	private Boolean aceitaTermos;
}

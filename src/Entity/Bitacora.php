<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

/**
 * Bitacora
 *
 * @ORM\Table(name="bitacora")
 * @ORM\Entity
 */
class Bitacora
{
    /**
     * @var int
     *
     * @ORM\Column(name="id", type="integer", nullable=false)
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="SEQUENCE")
     * @ORM\SequenceGenerator(sequenceName="bitacora_id_seq", allocationSize=1, initialValue=1)
     */
    private $id;

    /**
     * @var string|null
     *
     * @ORM\Column(name="email", type="string", nullable=true)
     */
    private $email;

    /**
     * @var string|null
     *
     * @ORM\Column(name="token", type="string", nullable=true)
     */
    private $token;

    /**
     * @var \DateTime|null
     *
     * @ORM\Column(name="fec_ini", type="datetime", nullable=true)
     */
    private $fecIni;

    /**
     * @var \DateTime|null
     *
     * @ORM\Column(name="fec_fin", type="datetime", nullable=true)
     */
    private $fecFin;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getEmail(): ?string
    {
        return $this->email;
    }

    public function setEmail(?string $email): self
    {
        $this->email = $email;

        return $this;
    }

    public function getToken(): ?string
    {
        return $this->token;
    }

    public function setToken(?string $token): self
    {
        $this->token = $token;

        return $this;
    }

    public function getFecIni(): ?\DateTimeInterface
    {
        return $this->fecIni;
    }

    public function setFecIni(?\DateTimeInterface $fecIni): self
    {
        $this->fecIni = $fecIni;

        return $this;
    }

    public function getFecFin(): ?\DateTimeInterface
    {
        return $this->fecFin;
    }

    public function setFecFin(?\DateTimeInterface $fecFin): self
    {
        $this->fecFin = $fecFin;

        return $this;
    }


}

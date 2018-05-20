<?php

namespace App\Controller;

use App\Entity\Pedido;
use App\Form\PedidoType;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

/**
 * @Route("/pedido")
 */
class PedidoController extends Controller
{
    /**
     * @Route("/", name="pedido_index", methods="GET")
     */
    public function index(): Response
    {
        $pedidos = $this->getDoctrine()
            ->getRepository(Pedido::class)
            ->findAll();

        return $this->render('pedido/index.html.twig', ['pedidos' => $pedidos]);
    }

    /**
     * @Route("/new", name="pedido_new", methods="GET|POST")
     */
    public function new(Request $request): Response
    {
        $pedido = new Pedido();
        $form = $this->createForm(PedidoType::class, $pedido);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $em = $this->getDoctrine()->getManager();
            $em->persist($pedido);
            $em->flush();

            return $this->redirectToRoute('pedido_index');
        }

        return $this->render('pedido/new.html.twig', [
            'pedido' => $pedido,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="pedido_show", methods="GET")
     */
    public function show(Pedido $pedido): Response
    {
        return $this->render('pedido/show.html.twig', ['pedido' => $pedido]);
    }

    /**
     * @Route("/{id}/edit", name="pedido_edit", methods="GET|POST")
     */
    public function edit(Request $request, Pedido $pedido): Response
    {
        $form = $this->createForm(PedidoType::class, $pedido);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $this->getDoctrine()->getManager()->flush();

            return $this->redirectToRoute('pedido_edit', ['id' => $pedido->getId()]);
        }

        return $this->render('pedido/edit.html.twig', [
            'pedido' => $pedido,
            'form' => $form->createView(),
        ]);
    }

    /**
     * @Route("/{id}", name="pedido_delete", methods="DELETE")
     */
    public function delete(Request $request, Pedido $pedido): Response
    {
        if ($this->isCsrfTokenValid('delete'.$pedido->getId(), $request->request->get('_token'))) {
            $em = $this->getDoctrine()->getManager();
            $em->remove($pedido);
            $em->flush();
        }

        return $this->redirectToRoute('pedido_index');
    }
}

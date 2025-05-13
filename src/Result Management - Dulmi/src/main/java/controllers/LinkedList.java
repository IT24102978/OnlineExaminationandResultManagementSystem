package controllers;

public class LinkedList {

    static class Node {
        String[] data;
        Node next;

        Node(String[] data) {
            this.data = data;
            this.next = null;
        }
    }

    private Node head = null;
    private Node tail = null;

    public void add(String[] data) {
        Node newNode = new Node(data);
        if (head == null) {
            head = newNode;
            tail = newNode;
        } else {
            tail.next = newNode;
            tail = newNode;
        }
    }

    public Node getHead() {
        return head;
    }

    public java.util.List<String[]> toList() {
        java.util.List<String[]> list = new java.util.ArrayList<>();
        Node current = head;
        while (current != null) {
            list.add(current.data);
            current = current.next;
        }
        return list;
    }
}

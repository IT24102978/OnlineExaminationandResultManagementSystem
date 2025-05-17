ppackage com.example.demo;

public class MyLinkedList {
    private Node head;

    public void add(Student student) {
        Node newNode = new Node(student);
        if (head == null) {
            head = newNode;
        } else {
            Node current = head;
            while (current.next != null) {
                current = current.next;
            }
            current.next = newNode;
        }
    }

    public Student searchById(String id) {
        Node current = head;
        while (current != null) {
            if (current.data.getId().equals(id)) {
                return current.data;
            }
            current = current.next;
        }
        return null;
    }

    public boolean deleteById(String id) {
        if (head == null) return false;

        if (head.data.getId().equals(id)) {
            head = head.next;
            return true;
        }

        Node current = head;
        while (current.next != null) {
            if (current.next.data.getId().equals(id)) {
                current.next = current.next.next;
                return true;
            }
            current = current.next;
        }
        return false;
    }

    public Node getHead() {
        return head;
    }
}


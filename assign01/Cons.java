public class Cons implements ImmutableList {
    // ---BEGIN INSTANCE VARIABLES---
    public final int head;
    public final ImmutableList tail;
    // ---END INSTANCE VARIABLES---

    public Cons(final int head, final ImmutableList tail) {
        this.head = head;
        this.tail = tail;
    } // Cons

    public boolean equals(final Object other) {
        if (other instanceof Cons) {
            final Cons otherCons = (Cons)other;
            return head == otherCons.head && tail.equals(otherCons.tail);
        } else {
            return false;
        }
    } // equals

    @Override
    public int length() {
        return tail.length() + 1;
    }

    @Override
    public int sum() {
        return tail.sum() + head;
    }

    @Override
    public ImmutableList append(final ImmutableList other) {
        return new Cons(head, tail.append(other));
    }

    @Override
    public boolean contains(int value) {
        if (tail.contains(value) || head == value) return true;
        return false;
    }

    public String toString() {
        return "Cons(" + head + ", " + tail.toString() + ")";
    } // toString

    public int hashCode() {
        return sum();
    } // hashCode
} // Cons

public class Nil implements ImmutableList {
    public Nil() {}

    public boolean equals(final Object other) {
        return other instanceof Nil;
    } // equals

    @Override
    public int length() {
        return 0;
    }

    @Override
    public int sum() {
        return 0;
    }

    @Override
    public boolean contains(final int value) {
        return false;
    }

    @Override
    public ImmutableList append(final ImmutableList other) {
        return other;
    }

    public String toString() {
        return "Nil";
    } // toString

    public int hashCode() {
        return 0;
    } // hashCode
} // Nil
    

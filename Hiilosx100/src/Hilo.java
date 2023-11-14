public class Hilo extends  Thread{
    public static int countAux;

    private int count;

    public static int getCountAux() {
        return countAux;
    }

    public static void setCountAux(int countAux) {
        Hilo.countAux = countAux;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public Hilo(int count) {
        countAux++;
        this.count = count;
    }

    @Override
    public void run() {
        System.out.println("Id: " + getCount());
    }
}

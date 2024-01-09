extension Stack<E> on List<E> {
  void push(E element) => add(element);
  E pop() => removeLast();
  E peek() => last;
}

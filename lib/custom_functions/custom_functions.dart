String toSentenceCase(String input) {
  if (input.isEmpty) {
    return input;
  }

  // Split the input into sentences based on periods (.)
  List<String> sentences = input.split('.');

  // Capitalize the first letter of each sentence
  for (int i = 0; i < sentences.length; i++) {
    sentences[i] = sentences[i].trim();
    if (sentences[i].isNotEmpty) {
      sentences[i] = sentences[i][0].toUpperCase() + sentences[i].substring(1).toLowerCase();
    }
  }

  // Join the sentences back into a single string
  return sentences.join('. ');
}
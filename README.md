# chatbot
import nltk
from nltk.chat.util import Chat, reflections
from nltk.stem import WordNetLemmatizer
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.linear_model import LogisticRegression

# Define a list of training examples
training_data = [
    ("hi", "Hello"),
    ("hey", "Hey there"),
    ("what is your name?", "You can call me Chatbot."),
    ("how are you?", "I'm doing good. How about you?"),
    ("what's up?", "Not much. How can I assist you?"),
    ("bye", "Goodbye! Take care."),
]

# Preprocess the training data
lemmatizer = WordNetLemmatizer()
processed_data = []
for pattern, response in training_data:
    processed_pattern = ' '.join([lemmatizer.lemmatize(word.lower()) for word in nltk.word_tokenize(pattern)])
    processed_data.append((processed_pattern, response))

# Extract features from the training data
vectorizer = TfidfVectorizer()
X_train = vectorizer.fit_transform([pattern for pattern, _ in processed_data])
y_train = [response for _, response in processed_data]

# Train a machine learning model
model = LogisticRegression()
model.fit(X_train, y_train)

# Create a Chat instance
chatbot = Chat([], reflections)

# Start the conversation
print("Hi, I'm Chatbot. How can I assist you today? (type quit to exit)")

while True:
    user_input = input("> ")
    if user_input.lower() == "quit":
        break
    
    # Preprocess the user input
    processed_input = ' '.join([lemmatizer.lemmatize(word.lower()) for word in nltk.word_tokenize(user_input)])
    
    # Extract features from the user input
    X_test = vectorizer.transform([processed_input])
    
    # Predict the response using the trained model
    predicted_response = model.predict(X_test)
    
    # Get the top predicted response
    response = predicted_response[0]
    
    print(response)

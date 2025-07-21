from app.main import app
import unittest


class BookApiTestCase(unittest.TestCase):
    def setUp(self):
        # Configure Flask pour le mode test
        self.app = app.test_client()
        self.app.testing = True

    def test_get_books(self):
        response = self.app.get('/books')
        self.assertEqual(response.status_code, 200)
        data = response.get_json()
        self.assertIsInstance(data, dict)
        self.assertGreaterEqual(len(data), 1)

    def test_get_book_by_id(self):
        response = self.app.get('/books/1')
        self.assertEqual(response.status_code, 200)
        book = response.get_json()
        self.assertIn('title', book)
        self.assertIn('author', book)
        self.assertIn('year', book)

    def test_add_book(self):
        new_book = {
            "title": "Test Book",
            "author": "Test Author",
            "year": 2024
        }
        response = self.app.post('/books', json=new_book)
        self.assertEqual(response.status_code, 201)
        data = response.get_json()
        self.assertEqual(data['title'], new_book['title'])

    def test_get_nonexistent_book(self):
        response = self.app.get('/books/9999')
        self.assertEqual(response.status_code, 404)

if __name__ == '__main__':
    unittest.main()

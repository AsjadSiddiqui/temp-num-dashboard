import axios from 'axios';
import { Request, Response } from 'express';

export const getPhoneInfo = async (req: Request, res: Response): Promise<void> => {
  try {
    const response = await axios.get('https://mocki.io/v1/635ce436-44ea-4137-b1dc-188e782cce2a');
    res.status(200).json(response.data);
  } catch (error) {
    let errorMessage = 'Error fetching phone information';
    if (error instanceof Error && error.message) {
      errorMessage = error.message;
    }
    res.status(500).json({ message: 'Error fetching phone information', error: errorMessage });
  }
};
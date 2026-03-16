import { GoogleGenerativeAI } from '@google/generative-ai';

export async function analyzeWithGemini(
  text: string,
  analysisType: 'summary' | 'qa' | 'sentiment' | 'entities' | 'extract',
) {
  const apiKey = process.env.GEMINI_API_KEY;
  if (!apiKey) {
    throw new Error('GEMINI API KEY is not set');
  }

  const genAI = new GoogleGenerativeAI(apiKey);

  const prompts = {
    summary: `Please provide a comprehensive summary of the following document. Include main points, key findings, and conclusions:\n\n${text}`,
    qa: `Based on the following document, generate 5 important questions and their answers:\n\n${text}`,
    sentiment: `Analyze the sentiment and tone of the following document. Provide overall sentiment (positive/negative/neutral) and key emotional tones detected:\n\n${text}`,
    entities: `Extract all named entities (people, organizations, locations, dates, etc.) from the following document:\n\n${text}`,
    extract: `Extract key information from the following document in structured format:\n\n${text}`,
  };

  if (!prompts[analysisType]) {
    throw new Error('Invalid analysis type');
  }

  try {
    const model = genAI.getGenerativeModel({ model: 'gemini-2.5-flash' });
    const result = await model.generateContent(prompts[analysisType]);
    const response = result.response;

    if (typeof response.text === 'function') {
      return response.text();
    }

    return String(response);
  } catch (error) {
    console.error('Gemini error:', error);
    return `Could not analyze for ${analysisType}`;
  }
}
